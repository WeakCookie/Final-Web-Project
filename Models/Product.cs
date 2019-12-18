//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Final_Project.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Product
    {
        public Product()
        {
            this.Feedbacks = new HashSet<Feedback>();
            this.Categories = new HashSet<Category>();
        }
    
        public int Id { get; set; }
        public string Name { get; set; }
        public double Price { get; set; }
        public System.DateTime CreatedAt { get; set; }
        public string Provider { get; set; }
        public string ShortDesc { get; set; }
        public string LongDesc { get; set; }
        public bool Active { get; set; }
        public int OrderId { get; set; }
    
        public virtual ICollection<Feedback> Feedbacks { get; set; }
        public virtual Order Order { get; set; }
        public virtual ICollection<Category> Categories { get; set; }
    }
}
