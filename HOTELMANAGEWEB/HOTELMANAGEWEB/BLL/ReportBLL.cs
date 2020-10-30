using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HOTELMANAGEWEB.Models;
using HOTELMANAGEWEB.DTO;

namespace HOTELMANAGEWEB.BLL
{
    public class ReportBLL
    {
        private static ReportBLL instance;

        public static ReportBLL Instance
        {
            get { if (instance == null) instance = new ReportBLL(); return instance; }
            private set => instance = value;
        }

        private ReportBLL() { }

        public int GetNewCustomer()
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.Database
                    .SqlQuery<int>("SELECT COUNT(*) FROM dbo.Customer WHERE MONTH(DateCreated) = MONTH(GETDATE())")
                    .FirstOrDefault();
            }
        }


        public int GetMaintenaceRoom()
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.Rooms.Count(x => x.RoomStatus == "MAINTENANCE");
            }
        }

        public int GetRentedRoom()
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.Rooms.Count(x => x.RoomStatus == "RENTED");
            }
        }

        public int TotalBooking()
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.Database
                    .SqlQuery<int>("SELECT COUNT (*) FROM Booking WHERE MONTH(DateCreated) = MONTH(GETDATE()) AND BookingStatus <> 'CANCEL'")
                    .FirstOrDefault();
            }
        }

        public int TotalCancelBooking()
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.Database
                    .SqlQuery<int>("SELECT COUNT (*) FROM Booking WHERE MONTH(DateCreated) = MONTH(GETDATE()) AND BookingStatus = 'CANCEL'")
                    .FirstOrDefault();
            }
        }

        public decimal GetTotal()
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.Database
                    .SqlQuery<decimal>("SELECT SUM(Total) FROM Bill WHERE MONTH(DateCreated) = MONTH(GETDATE()) AND BillStatus = 'PAID'")
                    .FirstOrDefault();
            }
        }
    }
}