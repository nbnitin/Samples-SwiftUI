//
//  Products.swift
//  A-ZStrip
//
//  Created by Nitin Bhatia on 30/05/26.
//
import SwiftUI

struct Products: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
}

struct ProductCategory: Identifiable {
    let id = UUID()
    let name: String
    let products: [Products]
    
    init(name: String, products: [Products]) {
        self.name = name
        self.products = products
    }
    
    public static let mockData: [ProductCategory] = [
        .init(name: "Fruits", products: [
            .init(name: "Apple", price: 1.0),
            .init(name: "Banana", price: 2.0),
            .init(name: "Orange", price: 3.0),
            .init(name: "Grapes", price: 4.0),
            .init(name: "Mango", price: 5.0),
            .init(name: "Pineapple", price: 6.0),
            .init(name: "Strawberry", price: 7.0),
            .init(name: "Blueberry", price: 8.0),
            .init(name: "Watermelon", price: 9.0),
            .init(name: "Peach", price: 10.0)
        ]),
        .init(name: "Vegetables", products: [
            .init(name: "Carrot", price: 1.0),
            .init(name: "Broccoli", price: 2.0),
            .init(name: "Spinach", price: 3.0),
            .init(name: "Potato", price: 4.0),
            .init(name: "Tomato", price: 5.0),
            .init(name: "Onion", price: 6.0),
            .init(name: "Pepper", price: 7.0),
            .init(name: "Cucumber", price: 8.0),
            .init(name: "Lettuce", price: 9.0),
            .init(name: "Cauliflower", price: 10.0)
        ]),
        .init(name: "Beverages", products: [
            .init(name: "Water", price: 1.0),
            .init(name: "Orange Juice", price: 2.0),
            .init(name: "Apple Juice", price: 3.0),
            .init(name: "Milk", price: 4.0),
            .init(name: "Coffee", price: 5.0),
            .init(name: "Tea", price: 6.0),
            .init(name: "Soda", price: 7.0),
            .init(name: "Lemonade", price: 8.0),
            .init(name: "Smoothie", price: 9.0),
            .init(name: "Energy Drink", price: 10.0)
        ]),
        .init(name: "Snacks", products: [
            .init(name: "Chips", price: 1.0),
            .init(name: "Cookies", price: 2.0),
            .init(name: "Crackers", price: 3.0),
            .init(name: "Nuts", price: 4.0),
            .init(name: "Popcorn", price: 5.0),
            .init(name: "Pretzels", price: 6.0),
            .init(name: "Granola Bar", price: 7.0),
            .init(name: "Jerky", price: 8.0),
            .init(name: "Trail Mix", price: 9.0),
            .init(name: "Rice Cakes", price: 10.0)
        ]),
        .init(name: "Dairy", products: [
            .init(name: "Milk", price: 1.0),
            .init(name: "Cheese", price: 2.0),
            .init(name: "Butter", price: 3.0),
            .init(name: "Yogurt", price: 4.0),
            .init(name: "Cream", price: 5.0),
            .init(name: "Ice Cream", price: 6.0),
            .init(name: "Cottage Cheese", price: 7.0),
            .init(name: "Sour Cream", price: 8.0),
            .init(name: "Ghee", price: 9.0),
            .init(name: "Paneer", price: 10.0)
        ]),
        .init(name: "Bakery", products: [
            .init(name: "Bread", price: 1.0),
            .init(name: "Bagel", price: 2.0),
            .init(name: "Croissant", price: 3.0),
            .init(name: "Muffin", price: 4.0),
            .init(name: "Bun", price: 5.0),
            .init(name: "Doughnut", price: 6.0),
            .init(name: "Cake", price: 7.0),
            .init(name: "Pie", price: 8.0),
            .init(name: "Biscuit", price: 9.0),
            .init(name: "Pita", price: 10.0)
        ]),
        .init(name: "Frozen Foods", products: [
            .init(name: "Frozen Pizza", price: 1.0),
            .init(name: "Frozen Vegetables", price: 2.0),
            .init(name: "Frozen Fries", price: 3.0),
            .init(name: "Frozen Peas", price: 4.0),
            .init(name: "Ice Cream", price: 5.0),
            .init(name: "Frozen Berries", price: 6.0),
            .init(name: "Frozen Meals", price: 7.0),
            .init(name: "Frozen Fish", price: 8.0),
            .init(name: "Frozen Chicken", price: 9.0),
            .init(name: "Frozen Waffles", price: 10.0)
        ]),
        .init(name: "Meat", products: [
            .init(name: "Chicken Breast", price: 1.0),
            .init(name: "Pork Chops", price: 2.0),
            .init(name: "Steak", price: 3.0),
            .init(name: "Ground Beef", price: 4.0),
            .init(name: "Lamb Chops", price: 5.0),
            .init(name: "Turkey", price: 6.0),
            .init(name: "Sausage", price: 7.0),
            .init(name: "Bacon", price: 8.0),
            .init(name: "Ham", price: 9.0),
            .init(name: "Duck", price: 10.0)
        ]),
        .init(name: "Seafood", products: [
            .init(name: "Salmon", price: 1.0),
            .init(name: "Shrimp", price: 2.0),
            .init(name: "Tuna", price: 3.0),
            .init(name: "Crab", price: 4.0),
            .init(name: "Lobster", price: 5.0),
            .init(name: "Oysters", price: 6.0),
            .init(name: "Clams", price: 7.0),
            .init(name: "Mussels", price: 8.0),
            .init(name: "Scallops", price: 9.0),
            .init(name: "Squid", price: 10.0)
        ]),
        .init(name: "Grains", products: [
            .init(name: "Rice", price: 1.0),
            .init(name: "Wheat", price: 2.0),
            .init(name: "Oats", price: 3.0),
            .init(name: "Barley", price: 4.0),
            .init(name: "Quinoa", price: 5.0),
            .init(name: "Corn", price: 6.0),
            .init(name: "Millet", price: 7.0),
            .init(name: "Rye", price: 8.0),
            .init(name: "Buckwheat", price: 9.0),
            .init(name: "Sorghum", price: 10.0)
        ]),
    ]
    
    public static func getProductNameInitials() -> [String] {
        let allProductNames = ProductCategory.mockData.flatMap(\.products).map(\.name)
        
        return Set(allProductNames).sorted()
    }
}

#Preview{
    ContentView()
}
