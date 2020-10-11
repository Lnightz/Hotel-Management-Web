using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HOTELMANAGEWEB.DAL
{
    public class RoomDetails
    {
        public int RoomID { get; set; }

        public string RoomName { get; set; }
        public string RoomStatus { get; set; }
        public int MinQuantity { get; set; }
        public int MaxQuantity { get; set; }
        public string RoomTypeName { get; set; }
        public decimal RoomTypePrices { get; set; }
        public int IsPay { get; set; }

    }
}