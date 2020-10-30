using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HOTELMANAGEWEB.Models;
using System.Data.Entity;

namespace HOTELMANAGEWEB.BLL
{
    public class InvoicesBLL
    {
        private static InvoicesBLL instance;

        public static InvoicesBLL Instance
        {
            get { if (instance == null) instance = new InvoicesBLL(); return instance; }
            private set => instance = value;
        }

        public List<Bill> GetListBill()
        {
            using ( var db = new QLKSWEBEntities())
            {
                return db.Bills
                        .ToList();
            }
        }

        public BillDetail GetBillDetailByID (int id)
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.BillDetails
                    .Include(x => x.Bill)
                    .Include(x => x.Room)
                    .Include(x => x.Service)
                    .Include(x => x.Room.RoomType)
                    .FirstOrDefault(x => x.BillID == id);
            }
        }
        public List<BillDetail> GetServicesInBillDetailByID (int id)
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.BillDetails.Include(x => x.Service)
                        .Include(x => x.Service.ServicesType).Where(x=>x.BillID == id)
                        .ToList();
            }
        }

        public decimal GetSumTotalServicesById(int id)
        {
            using ( var db = new QLKSWEBEntities())
            {
                var total = db.BillDetails.Where(x=>x.BillID == id).Sum(x => x.TotalSerivcesPrices);
                return Convert.ToDecimal(total);
            }
        }

        public int GetBillIDByRoomID(int roomid)
        {
            using (var db = new QLKSWEBEntities())
            {
                var bill = db.BillDetails
                            .Include(x => x.Bill)
                            .Include(x => x.Room)
                            .Where(x => x.RoomID == roomid && x.Bill.BillStatus == "OPEN")
                            .FirstOrDefault();
                if (bill != null)
                {
                    return Convert.ToInt32(bill.BillID);
                }
                else return -1;
            }
        }

        public int GetRoomIDByBillID(int? BillID)
        {
            using (var db = new QLKSWEBEntities())
            {
                var bill = db.BillDetails
                        .Where(x => x.BillID == BillID).FirstOrDefault();
                return (int)bill.RoomID;
            }
        }

    }
}