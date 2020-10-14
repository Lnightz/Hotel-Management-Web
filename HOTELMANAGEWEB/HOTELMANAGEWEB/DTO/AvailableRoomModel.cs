using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HOTELMANAGEWEB.DAL
{
    public class AvailableRoomModel
    {
        public string RoomTypeName { get; set; }

        public string RoomTypeDescription { get; set; }

        public decimal RoomTypePrices { get; set; }

        public string RoomTypeImage { get; set; }
    }
}