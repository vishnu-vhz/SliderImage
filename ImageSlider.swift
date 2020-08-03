
import Foundation

public class ImageSlider : UIView{
    var collection : UICollectionView!
    var pageController : UIPageControl!
    var pageNumber = CGFloat()
    var timer = Timer()
     var counter = 0
     let customCellId = "cell"
    ///IB Inspectable
    //var collectionView = UICollectionView()
    
    required public init(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)!
          
          //setupUI()
        collection.delegate = self
        collection.dataSource = self
        collection.register(customImageCell.self, forCellWithReuseIdentifier: customCellId)
        
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(pageNumber), target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        //collection.isDirectionalLockEnabled =
      }
    
    fileprivate  var dataArray = [String]()
       public var imageArray = [String]() {
           didSet{
               self.dataArray = self.imageArray
           }
       }
    
    @objc func changeImage(){
        if counter < dataArray.count{
            let index = IndexPath.init(item: counter, section: 0)
            self.collection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageController.currentPage = counter
            counter += 1
        }else{
            counter = 0
             let index = IndexPath.init(item: counter, section: 0)
             self.collection.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageController.currentPage = counter
             counter = 1
        }
        
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
    
    @IBInspectable public var timeInterval: CGFloat = 1.0 {
              didSet {
                  pageNumber = timeInterval
              }
          }
    

    
}
extension ImageSlider : UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
 
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
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


