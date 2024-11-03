import UIKit

class CustomView: UIView {
    
    var subviewsCache: [UIView] = []
    
    // Method to set spacing between subviews
    func spacing(subviews: [UIView], cache: [UIView]) {
        // Ensure the cache is updated
        subviewsCache = cache
        
        let spacing: CGFloat = 10.0 // Define the desired spacing
        
        // Remove old constraints
        self.removeConstraints(self.constraints)
        
        // Add each subview and set its constraints
        var previousSubview: UIView?
        for subview in subviews {
            self.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
            
            // Set leading and trailing constraints
            NSLayoutConstraint.activate([
                subview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing),
                subview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacing)
            ])
            
            // Set top constraints relative to the previous subview (or top anchor if first)
            if let previous = previousSubview {
                NSLayoutConstraint.activate([
                    subview.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: spacing)
                ])
            } else {
                NSLayoutConstraint.activate([
                    subview.topAnchor.constraint(equalTo: self.topAnchor, constant: spacing)
                ])
            }
            
            previousSubview = subview
        }
        
        // Set bottom constraint for the last subview
        if let lastSubview = subviews.last {
            NSLayoutConstraint.activate([
                lastSubview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -spacing)
            ])
        }
    }
}
