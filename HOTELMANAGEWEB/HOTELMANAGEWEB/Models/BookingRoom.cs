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
    
    public partial class BookingRoom
    {
        public int BookingRoomID { get; set; }
        public Nullable<int> BookingID { get; set; }
        public Nullable<int> RoomID { get; set; }
        public Nullable<byte> IsBooking { get; set; }
    
        public virtual Booking Booking { get; set; }
        public virtual Room Room { get; set; }
    }
}
