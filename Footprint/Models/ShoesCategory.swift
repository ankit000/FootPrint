

import Foundation

public class ShoesCategory {
	public var id : Int?
	public var title : String?
    public var thumbUrl : String?
    public var Subcatagories : [[String:Any]]?
    
/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let ShoesCategory_list = ShoesCategory.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of ShoesCategory Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [ShoesCategory]
    {
        var models:[ShoesCategory] = []
        for item in array
        {
            models.append(ShoesCategory(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let ShoesCategory = ShoesCategory(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: ShoesCategory Instance.
*/
	required public init?(dictionary: NSDictionary) {

		id = dictionary["id"] as? Int
		title = dictionary["title"] as? String
        thumbUrl = dictionary["thumbUrl"] as? String
        Subcatagories = dictionary["Subcatagories"] as? [[String:Any]]
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.title, forKey: "title")
		dictionary.setValue(self.thumbUrl, forKey: "thumbUrl")
        dictionary.setValue(self.Subcatagories, forKey: "Subcatagories")

		return dictionary
	}

}
