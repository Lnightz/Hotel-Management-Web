using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HOTELMANAGEWEB.DTO
{
    public class BookingRoomModel
    {
        public int BookingRoomID { get; set; }

        public int BookingID { get; set; }
        public string BookingStatus { get; set; }

        public DateTime BookDate { get; set; }
        public DateTime CheckinDate { get; set; }

        public DateTime CheckoutDate { get; set; }

        public string CustomerName { get; set; }
    }
}