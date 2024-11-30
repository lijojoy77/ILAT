//
//  ILATestApp.swift
//  ILATest
//
//  Created by Lijo Joy on 29/11/2024.
//

import SwiftUI

@main
struct ILATestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
/*
 
 HStack {
     TextField("Search", text: $text)
         .padding()
         .background(Color.gray.opacity(0.2))
         .cornerRadius(10)
 }
 .padding(.horizontal)
 .padding(.top)
 .frame(height: 60)
//  .zIndex(1)
import SwiftUI

struct ContentView: View {
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
        ["Apple", "Apricot", "Avocado", "Banana", "Blueberry", "Blackberry", "Cherry", "Coconut", "Cranberry"],
        ["Banana", "Blueberry", "Blackberry"],
        ["Cherry", "Coconut", "Cranberry"]
    ]
    
    @State private var displayedItems: [String] = []
    
    init() {
        // Initialize displayedItems with the first set of items
        _displayedItems = State(initialValue: allItems.first ?? [])
    }
    
    var body: some View {
      //  NavigationView {
            ZStack(alignment: .top) {
                // Scrollable content
                ScrollView {
                    VStack(spacing: 0) {
                        // Image carousel
                        TabView(selection: $selectedImageIndex) {
                            ForEach(imageUrls.indices, id: \.self) { index in
                                AsyncImage(
                                    url: URL(string: imageUrls[index]),
                                    content: { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 200)
                                            .clipped()
                                            .tag(index)
                                    },
                                    placeholder: {
                                        ProgressView()
                                            .frame(height: 200)
                                    }
                                )
                                .onTapGesture {
                                    updateDisplayedItems(for: index)
                                }
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .frame(height: 200)
                        .onChange(of: selectedImageIndex) { newIndex in
                            updateDisplayedItems(for: newIndex)
                        }
                        
                        // Pager (Radio Button Style)
                        HStack {
                            ForEach(imageUrls.indices, id: \.self) { index in
                                Circle()
                                    .fill(selectedImageIndex == index ? Color.blue : Color.gray)
                                    .frame(width: 10, height: 10)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedImageIndex = index
                                        }
                                    }
                            }
                        }
                        .padding(.vertical, 8)
                        
                        Spacer().frame(height: 60) // Placeholder for the sticky search bar
                        
                        // List
                        LazyVStack(alignment: .leading, spacing: 10) {
                            ForEach(filteredItems, id: \.self) { item in
                                HStack {
                                    AsyncImage(
                                        url: URL(string: "https://via.placeholder.com/50"),
                                        content: { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .cornerRadius(8)
                                        },
                                        placeholder: {
                                            ProgressView()
                                                .frame(width: 50, height: 50)
                                        }
                                    )
                                    Text(item)
                                        .font(.headline)
                                    Spacer()
                                }
                                .padding()
                                .background(Color(UIColor.secondarySystemGroupedBackground))
                                .cornerRadius(8)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                    }
                }
                
                // Sticky Search Bar
                SearchBar(text: $searchText)
                    .background(Color(UIColor.systemBackground)) // Match system background for seamless look
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2) // Optional shadow
            }
//            .navigationTitle("Image Carousel & List")
//        }
    }
    
    // Update displayed list based on selected image index
    private func updateDisplayedItems(for index: Int) {
        if index < allItems.count {
            displayedItems = allItems[index]
        }
    }
    
    // Filtered list based on search input
    private var filteredItems: [String] {
        if searchText.isEmpty {
            return displayedItems
        } else {
            return displayedItems.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

// Search bar implementation
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(8)
                .padding(.horizontal, 16)
                .background(Color(UIColor.systemGray5))
                .cornerRadius(8)
        }
        .padding(.horizontal)
        .padding(.top)
        .frame(height: 60) // Ensure consistent height
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}*/


/*
import SwiftUI

struct ContentView: View {
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
        ["Apple", "Apricot", "Avocado","Banana", "Blueberry", "Blackberry","Cherry", "Coconut", "Cranberry"],
        ["Banana", "Blueberry", "Blackberry"],
        ["Cherry", "Coconut", "Cranberry"]
    ]
    
    @State private var displayedItems: [String] = []
    
    init() {
        // Initialize displayedItems with the first set of items
        _displayedItems = State(initialValue: allItems.first ?? [])
    }
    
    var body: some View {
            VStack {
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        // Image carousel
                        TabView(selection: $selectedImageIndex) {
                            ForEach(imageUrls.indices, id: \.self) { index in
                                AsyncImage(
                                    url: URL(string: imageUrls[index]),
                                    content: { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 200)
                                            .clipped()
                                            .tag(index)
                                    },
                                    placeholder: {
                                        ProgressView()
                                            .frame(height: 200)
                                    }
                                )
                                .onTapGesture {
                                    updateDisplayedItems(for: index)
                                }
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .frame(height: 200)
                        .onChange(of: selectedImageIndex) { newIndex in
                            updateDisplayedItems(for: newIndex)
                        }
                        
                        // Pager (Radio Button Style)
                        HStack {
                            ForEach(imageUrls.indices, id: \.self) { index in
                                Circle()
                                    .fill(selectedImageIndex == index ? Color.blue : Color.gray)
                                    .frame(width: 10, height: 10)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedImageIndex = index
                                        }
                                    }
                            }
                        }
                        .padding(.vertical, 8)
                        
                        // Search bar
                        SearchBar(text: $searchText)
                        
                        // List
                        LazyVStack(alignment: .leading, spacing: 10) {
                            ForEach(filteredItems, id: \.self) { item in
                                HStack {
                                    AsyncImage(
                                        url: URL(string: "https://via.placeholder.com/50"),
                                        content: { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .cornerRadius(8)
                                        },
                                        placeholder: {
                                            ProgressView()
                                                .frame(width: 50, height: 50)
                                        }
                                    )
                                    Text(item)
                                        .font(.headline)
                                    Spacer()
                                }
                                .padding()
                                .background(Color(UIColor.secondarySystemGroupedBackground))
                                .cornerRadius(8)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                    }
                }
            }
    }
    
    // Update displayed list based on selected image index
    private func updateDisplayedItems(for index: Int) {
        if index < allItems.count {
            displayedItems = allItems[index]
        }
    }
    
    // Filtered list based on search input
    private var filteredItems: [String] {
        if searchText.isEmpty {
            return displayedItems
        } else {
            return displayedItems.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

// Search bar implementation
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(8)
                .padding(.horizontal, 16)
                .background(Color(UIColor.systemGray5))
                .cornerRadius(8)
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
