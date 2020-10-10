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
    
    public partial class Booking
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Booking()
        {
            this.BookingRooms = new HashSet<BookingRoom>();
            this.BookingServices = new HashSet<BookingService>();
        }
    
        public int BookingID { get; set; }
        public Nullable<System.DateTime> BookDate { get; set; }
        public Nullable<System.DateTime> CheckinDate { get; set; }
        public Nullable<System.DateTime> CheckoutDate { get; set; }
        public Nullable<decimal> Deposit { get; set; }
        public string BookingType { get; set; }
        public string BookingStatus { get; set; }
        public string BookingNotes { get; set; }
        public Nullable<int> CreatedUserID { get; set; }
        public Nullable<int> CustomerID { get; set; }
        public Nullable<int> ModifyUserID { get; set; }
        public Nullable<System.DateTime> DateCreated { get; set; }
        public Nullable<System.DateTime> DateModify { get; set; }
    
        public virtual Account Account { get; set; }
        public virtual Customer Customer { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BookingRoom> BookingRooms { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BookingService> BookingServices { get; set; }
    }
}
