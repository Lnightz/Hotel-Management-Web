using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace HOTELMANAGEWEB.DTO
{
    public class AvailableRoomModel
    {
        public int RoomTypeID { get; set; }
        public string RoomTypeName { get; set; }

        public string RoomTypeDescription { get; set; }
        public decimal RoomTypePrices { get; set; }

        public string RoomTypeImage { get; set; }
    }
}