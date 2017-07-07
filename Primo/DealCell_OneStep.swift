import UIKit
import SDWebImage

class DealCell_OneStep: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func SetData(deal: Deal)
    {
        // color bar
        if let subview = self.viewWithTag(101) {
            if (deal.isOwnedDeal!) {
                subview.backgroundColor = PrimoColor.Green.UIColor
            } else {
                subview.backgroundColor = PrimoColor.Red.UIColor
            }
        }
        
        // card image
        if let subview = self.viewWithTag(102) as? UIImageView {
            let defaultCard = #imageLiteral(resourceName: "card_error")
            let block = { (image: UIImage?, error: Error?, cache: SDImageCacheType, url: URL?) in
                if (error != nil) {
                    print(error!)
                } else {
                    deal.card?.image = image
                    //print("Got Image")
                }
            }
            subview.sd_setImage(with: URL(string: (deal.card?.imgUrl)!),
                                placeholderImage: defaultCard,
                                options: .retryFailed,
                                completed: block)
        }
        
        // is owned deal text
        if let subview = self.viewWithTag(104) as? UILabel {
            if (deal.isOwnedDeal!) {
                // owned deal
                subview.text = DealPage.UnderCardText_OwnedDeal.rawValue
                subview.textColor = PrimoColor.Green.UIColor
            } else {
                // not owned
                subview.text = DealPage.UnderCardText_NotOwn.rawValue
                subview.textColor = PrimoColor.Red.UIColor
            }
        }
        
        // deal title
        if let subview = self.viewWithTag(105) as? UILabel {
            subview.lineBreakMode = .byWordWrapping
            subview.numberOfLines = 0
            subview.text = deal.title
        }
        
        // deal value
        if let subview = self.viewWithTag(106) as? UILabel {
            let value = deal.totalReward
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            subview.text = (formatter.string(from: NSNumber(value: value!)) ?? "0") + " ฿"
        }
        
        // deal value bg
        if let subview = self.viewWithTag(107) {
            subview.clipsToBounds = true
            subview.layer.cornerRadius = 5
        }
        
        // medal image
        if let subview = self.viewWithTag(108) as? UIImageView
        {
            if (deal.rank != nil)
            {
                switch deal.rank! {
                case 1:
                    subview.image = #imageLiteral(resourceName: "medal_gold")
                    break
                case 2:
                    subview.image = #imageLiteral(resourceName: "medal_sliver")
                    break
                case 3:
                    subview.image = #imageLiteral(resourceName: "medal_bronze")
                    break
                default:
                    subview.image = nil
                    break
                }
            } else {
                subview.image = nil
            }
        }
    }
}