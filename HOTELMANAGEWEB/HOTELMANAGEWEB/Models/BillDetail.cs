//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace HOTELMANAGEWEB.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class BillDetail
    {
        public int BillDetailID { get; set; }
        public Nullable<int> Quantity { get; set; }
        public Nullable<decimal> TotalSerivcesPrices { get; set; }
        public Nullable<decimal> Compensation { get; set; }
        public Nullable<int> ServicesID { get; set; }
        public Nullable<int> RoomID { get; set; }
        public Nullable<int> BillID { get; set; }
    
        public virtual Bill Bill { get; set; }
        public virtual Room Room { get; set; }
        public virtual Service Service { get; set; }
    }
}
