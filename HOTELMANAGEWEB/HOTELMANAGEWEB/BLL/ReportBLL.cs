using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HOTELMANAGEWEB.Models;
using HOTELMANAGEWEB.DTO;
using System.Data.SqlClient;
using Microsoft.Ajax.Utilities;

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
                var result =  db.Database
                    .SqlQuery<decimal?>("SELECT SUM(Total) FROM Bill WHERE MONTH(DateCreated) = MONTH(GETDATE()) AND BillStatus = 'PAID'")
                    .FirstOrDefault();
                if (result != null)
                {
                    return (decimal)result;
                }
                return 0;
            }
        }

        public decimal GetTotalServices()
        {
            using (var db = new QLKSWEBEntities())
            {
                var result =  db.Database
                    .SqlQuery<decimal?>("SELECT SUM(T1.TotalSerivcesPrices) FROM BillDetail T1 INNER JOIN BIll T2 ON T2.BillID = T1.BillID WHERE T2.BillStatus = 'PAID'")
                    .FirstOrDefault();
                if (result != null)
                {
                    return (decimal)result;
                }
                return 0;
            }
        }

        public decimal GetTotalRoom()
        {
            using (var db = new QLKSWEBEntities())
            {
                var result =  db.Database
                    .SqlQuery<decimal?>("EXEC dbo.TotalRoomRevenue")
                    .FirstOrDefault();
                if (result != null)
                {
                    return (decimal)result;
                }
                return 0;
            }
        }

        public List<PieChartModel> pieChartModels(int month, int year)
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.Database
                    .SqlQuery<PieChartModel>
                    ("EXEC RoomTypePie @Month, @Year",
                    new SqlParameter("@Month", month),
                    new SqlParameter("@Year", year))
                    .ToList();
            }
        }

        public List<SalesChartModel> salesChartModels(int month, int year)
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.Database
                    .SqlQuery<SalesChartModel>("EXEC SaleChart @Month, @Year",
                    new SqlParameter("@Month", month),
                    new SqlParameter("Year", year)).ToList();
            }
        }
    }
}