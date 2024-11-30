//
//  Home.swift
//  ILATest
//
//  Created by Lijo Joy on 30/11/2024.
//

import SwiftUI

struct Home: View {
    // MARK: - Properties
    var safeArea: EdgeInsets
    var size: CGSize
    
    @State private var selectedImageIndex = 0
    @State private var searchText = ""
    
    // Image URLs
    let imageUrls = [
        "https://via.placeholder.com/400x200?text=Image+1",
        "https://via.placeholder.com/400x200?text=Image+2",
        "https://via.placeholder.com/400x200?text=Image+3"
    ]
    
    // Example list data
    let allItems = [
        ["Apple", "Apricot", "Avocado", "Banana", "Blueberry", "Blackberry", "Cherry", "Coconut", "Cranberry", "Orange", "Grapes", "Jackfruit"],
        ["Banana", "Blueberry", "Blackberry"],
        ["Cherry", "Coconut", "Cranberry"]
    ]
    
    @State private var displayedItems: [String] = []
    
    init(safeArea: EdgeInsets, size: CGSize) {
        self.safeArea = safeArea
        self.size = size
        // The @State property displayedItems cannot be initialized here
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                // MARK: - Image Carousel
                ImageCarousel()
                
                // Sticky Search Bar
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY - safeArea.top
                    SearchBar(text: $searchText)
                        .offset(y: minY < 50 ? -(minY - 50) : 0)
                }
                .frame(height: 50)
                .padding(.top, -34)
                .zIndex(1)
                
                // Popular Items Section
                VStack {
                    // MARK: - List of Items
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(filteredItems, id: \.self) { item in
                            VStack {
                                HStack {
                                    // Image aligned to leading
                                    AsyncImage(
                                        url: URL(string: "https://via.placeholder.com/50"),
                                        content: { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30) // Reduced image size
                                                .cornerRadius(2)
                                        },
                                        placeholder: {
                                            ProgressView()
                                                .frame(width: 30, height: 30) // Reduced size of placeholder
                                        }
                                    )
                                    
                                    // Text aligned to center
                                    Text(item)
                                        .font(.subheadline)
                                        .frame(maxWidth: .infinity, alignment: .center) // Align text to center
                                        .foregroundColor(.black)
                                    
                                    Spacer() // Ensures that text is centered in the HStack
                                }
                                .padding(8) // Reduced padding for smaller cells
                                .background(Color.white)
                                .cornerRadius(8)
                                .padding(.horizontal)

                                // Grey separator line between cells
                                Divider()
                                    .background(Color.gray)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.top, 20)
                }
                .zIndex(0)
            }
            .background(Color.white)
        }
        .background(Color.white)
        .coordinateSpace(name: "SCROLL")
        .onAppear {
            // Initialize displayedItems on appear
            displayedItems = allItems.first ?? []
        }
    }
    
    @ViewBuilder
    func ImageCarousel() -> some View {
        let height = size.height * 0.25
        VStack(spacing: 10) { // Added spacing for the pager
            // Image Carousel
            TabView(selection: $selectedImageIndex) {
                ForEach(imageUrls.indices, id: \.self) { index in
                    AsyncImage(
                        url: URL(string: imageUrls[index]),
                        content: { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: height)
                                .clipped()
                        },
                        placeholder: {
                            ProgressView()
                                .frame(height: height)
                        }
                    )
                    .tag(index)
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        updateDisplayedItems(for: index)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: height)
            .onChange(of: selectedImageIndex) { newIndex in
                updateDisplayedItems(for: newIndex)
            }
            
            // Custom Pager Indicator
            HStack(spacing: 8) {
                ForEach(imageUrls.indices, id: \.self) { index in
                    Circle()
                        .fill(selectedImageIndex == index ? Color.white : Color.gray.opacity(0.5))
                        .frame(width: 8, height: 8)
                }
            }
        }
        .padding(.top, 66) // Add padding above the carousel
    }

    
    // MARK: - Update displayed list based on selected image index
    private func updateDisplayedItems(for index: Int) {
        if index < allItems.count {
            displayedItems = allItems[index]
        }
    }
    
    // MARK: - Filtered list based on search input
    private var filteredItems: [String] {
        if searchText.isEmpty {
            return displayedItems
        } else {
            return displayedItems.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
}

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        ZStack {
            // Outside background as grey
            Color.gray.opacity(0.2)
                .edgesIgnoringSafeArea(.horizontal)
            
            HStack {
                // Search lens icon inside the text field
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 12)
                
                // TextField with white background and green placeholder text
                ZStack(alignment: .leading) {
                    // Placeholder text
                    if text.isEmpty {
                        Text("Search")
                            .foregroundColor(.gray)
                            .padding(.leading, 16)
                            .padding(.top, 10)
                            .background(.black)
                    }
                    TextField("", text: $text)
                        .padding(12)
                        .padding(.horizontal, 16)
                        .background(Color.white)
                        .cornerRadius(8)
                        .foregroundColor(.black) // Text color inside the field
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 8) // Adjust vertical padding if necessary
            .cornerRadius(8)
        }
        .frame(height: 50) // Fixed height for the search bar
        .padding(.top)
        .padding(.bottom)
    }
}
