using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Final_Project.Models
{
    public class ProductViewModel
    {
        private Product _product;
        public ProductViewModel(Product product)
        {
            _product = product;
            ProId = product.Id;
            ProName = product.Name;
            ProPrice = product.Price;
            ProCreated = product.CreatedAt;
            ProProvider = product.Provider;
            ProShortDesc = product.ShortDesc;
            ProLongDesc = product.LongDesc;
            ProImagePath = product.ImagePath;
            ProActive = product.Active;
            ProOrderId = product.OrderId;
            ProFeedBacks = product.Feedbacks;
            ProOrder = product.Order;
            Categories = product.Categories;
            Id = product.Categories.Select(c => c.Id).ToList();


        }

        public void UpdateProduct(Product product)
        {
            product.Id = ProId;
            product.Name = ProName;
            product.Provider = ProProvider;
            product.Price = ProPrice;
            product.ShortDesc = ProShortDesc;
            product.ImagePath = ProImagePath;
            product.LongDesc = ProLongDesc;
            product.CreatedAt = ProCreated;
            product.Active = ProActive;
        }    
     
        public int ProId { get; set; }
        public string ProName { get; set; }
        public double ProPrice { get; set; }
        public DateTime ProCreated { get; set; }
        public string ProProvider { get; set; }
        public string ProShortDesc { get; set; }
        public string ProLongDesc { get; set; }
        public string ProImagePath { get; set; }
        public bool ProActive { get; set; }
        public int ProOrderId { get; set; }
        public ICollection<Feedback> ProFeedBacks { get;  set; }
        public Order ProOrder { get; set; }
        public ICollection<Category> Categories { get; set; }
        public List<int> Id { get; set; }
    }
}