public class Main {
    public static void main(String[] args) {
        // Sample products
        Product[] products = {
            new Product(101, "Laptop", "Electronics"),
            new Product(205, "Shoes", "Fashion"),
            new Product(150, "Smartphone", "Electronics"),
            new Product(305, "Book", "Education")
        };

        // Linear Search
        System.out.println("Linear Search for product ID 205:");
        Product result1 = Search.linearSearch(products, 205);
        if (result1 != null) {
            System.out.println(result1);
        } else {
            System.out.println("Product not found");
        }

        // Binary Search
        System.out.println("\nBinary Search for product ID 150:");
        Product result2 = Search.binarySearch(products, 150);
        if (result2 != null) {
            System.out.println(result2);
        } else {
            System.out.println("Product not found");
        }
    }
}
