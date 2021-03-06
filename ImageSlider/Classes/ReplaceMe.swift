
import Foundation

public class ImageSlider : UIView{
    var collection : UICollectionView!
    var pageController : UIPageControl!
    var pageNumber = Int()

     let customCellId = "cell"
    ///IB Inspectable
    //var collectionView = UICollectionView()
    
    required public init(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)!
          
          //setupUI()
        collection.delegate = self
        collection.dataSource = self
        collection.register(customImageCell.self, forCellWithReuseIdentifier: customCellId)
        //collection.isDirectionalLockEnabled =
      }
    
    
          @IBInspectable public var borderWidth: CGFloat = 1.0 {
              didSet {
                  layer.borderWidth = borderWidth
              }
          }
    
        @IBInspectable public var borderColor: UIColor =  UIColor.lightGray {
              didSet {
                  layer.borderColor = borderColor.cgColor
              }
          }
    
          @IBInspectable public var cornerRadius: CGFloat = 5.0 {
              didSet {
                  layer.cornerRadius = cornerRadius
              }
          }
    
          @IBInspectable public var imageNumber: Int = 5 {
              didSet {
                  pageNumber = imageNumber
              }
          }
    
    fileprivate  var dataArray = [String]()
       public var imageArray = [String]() {
           didSet{
               self.dataArray = self.imageArray
           }
       }
    
}
extension ImageSlider : UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
 
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNumber
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       // let reuseIdentifier = "cell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellId, for: indexPath as IndexPath) as! customImageCell
        //cell..image = pageNumber[indexPath.row]
       // cell.image
        //cell.image
        let yourImage: UIImage = UIImage(named: dataArray[indexPath.row])!
        cell.scrollImage.image = yourImage
        return cell
               
    }
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width:self.bounds.width, height: self.bounds.height)

    }
    
}

class customImageCell: UICollectionViewCell {
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let scrollImage : UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 5.0
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
        
    }()
    func setupViews(){
        addSubview(self.scrollImage)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":scrollImage]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":scrollImage]))
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


