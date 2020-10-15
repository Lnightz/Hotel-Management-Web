using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace HOTELMANAGEWEB.DTO
{
    public class CheckAvailableRooms
    {
        public int NumberPerson { get; set; }
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? CheckinDate { get; set; }
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? CheckoutDate { get; set; }

        public int CompareDate
        {
            get
            {
                if (CheckoutDate < CheckinDate)
                {
                    return -1;
                }
                else
                {
                    return 1;
                }
            }
        }

        public int CheckDateNull
        {
            get
            {
                if (CheckinDate == null)
                {
                    return -1;
                }
                else if (CheckoutDate == null)
                {
                    return -2;
                }
                else if (CheckinDate == null && CheckoutDate == null)
                {
                    return -3;
                }
                else return 1;
            }
        }
    }
}