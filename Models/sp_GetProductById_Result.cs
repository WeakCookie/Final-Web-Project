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
    
    public partial class sp_GetProductById_Result
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public double Price { get; set; }
        public System.DateTime CreatedAt { get; set; }
        public string Provider { get; set; }
        public string ShortDesc { get; set; }
        public string LongDesc { get; set; }
        public bool Active { get; set; }
        public int OrderId { get; set; }
        public string ImagePath { get; set; }
    }
}
