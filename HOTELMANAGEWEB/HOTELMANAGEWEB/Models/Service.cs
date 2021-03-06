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
    
    public partial class Service
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Service()
        {
            this.BillDetails = new HashSet<BillDetail>();
            this.BookingServices = new HashSet<BookingService>();
            this.RoomServices = new HashSet<RoomService>();
        }
    
        public int ServicesID { get; set; }
        public string ServicesName { get; set; }
        public string ServicesDescription { get; set; }
        public string ServicesContent { get; set; }
        public Nullable<decimal> ServicesPrices { get; set; }
        public string Unit { get; set; }
        public string ServicesDetail { get; set; }
        public int ServicesTypeID { get; set; }
        public Nullable<int> CreatedUserID { get; set; }
        public Nullable<int> ModifyUserID { get; set; }
        public Nullable<System.DateTime> DateCreated { get; set; }
        public Nullable<System.DateTime> DateModify { get; set; }
        public Nullable<bool> IsAvailable { get; set; }
        public Nullable<bool> IsPay { get; set; }
        public Nullable<bool> IsShowHomePage { get; set; }
        public Nullable<bool> IsShow { get; set; }
        public string Image { get; set; }
        public Nullable<bool> IsBookWithRoom { get; set; }
        public bool IsSelected { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BillDetail> BillDetails { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BookingService> BookingServices { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RoomService> RoomServices { get; set; }
        public virtual ServicesType ServicesType { get; set; }
    }
}
