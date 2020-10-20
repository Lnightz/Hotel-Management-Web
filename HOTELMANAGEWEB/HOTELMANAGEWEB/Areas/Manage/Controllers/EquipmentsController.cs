using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using HOTELMANAGEWEB.Models;

namespace HOTELMANAGEWEB.Areas.Manage.Controllers
{
    public class EquipmentsController : Controller
    {
        private QLKSWEBEntities db = new QLKSWEBEntities();

        // GET: Manage/Equipments
        public ActionResult Index()
        {
            var equipments = db.Equipments.Include(e => e.EquipmentType).Include(e => e.Room);
            return View(equipments.ToList());
        }

        // GET: Manage/Equipments/Create
        public ActionResult Create()
        {
            ViewBag.EquipmentTypeID = new SelectList(db.EquipmentTypes, "EquipmentTypeID", "EquipmentTypeName");
            ViewBag.RoomID = new SelectList(db.Rooms, "RoomID", "RoomName");
            return View();
        }

        // POST: Manage/Equipments/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "EquipmentID,EquipmentName,EquipPrices,DateBuy,EquipStatus,EquipmentTypeID,RoomID,CreatedUserID,ModifyUserID,DateCreated,DateModify,Image")] Equipment equipment)
        {
            if (ModelState.IsValid)
            {
                db.Equipments.Add(equipment);
                db.SaveChanges();
                return RedirectToAction("Manage-43", "Manage");
            }

            ViewBag.EquipmentTypeID = new SelectList(db.EquipmentTypes, "EquipmentTypeID", "EquipmentTypeName", equipment.EquipmentTypeID);
            ViewBag.RoomID = new SelectList(db.Rooms, "RoomID", "RoomName", equipment.RoomID);
            return View(equipment);
        }

        // GET: Manage/Equipments/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Equipment equipment = db.Equipments.Find(id);
            if (equipment == null)
            {
                return HttpNotFound();
            }
            ViewBag.EquipmentTypeID = new SelectList(db.EquipmentTypes, "EquipmentTypeID", "EquipmentTypeName", equipment.EquipmentTypeID);
            ViewBag.RoomID = new SelectList(db.Rooms, "RoomID", "RoomName", equipment.RoomID);
            return View(equipment);
        }

        // POST: Manage/Equipments/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "EquipmentID,EquipmentName,EquipPrices,DateBuy,EquipStatus,EquipmentTypeID,RoomID,CreatedUserID,ModifyUserID,DateCreated,DateModify,Image")] Equipment equipment)
        {
            if (ModelState.IsValid)
            {
                db.Entry(equipment).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Manage-43", "Manage");
            }
            ViewBag.EquipmentTypeID = new SelectList(db.EquipmentTypes, "EquipmentTypeID", "EquipmentTypeName", equipment.EquipmentTypeID);
            ViewBag.RoomID = new SelectList(db.Rooms, "RoomID", "RoomName", equipment.RoomID);
            return View(equipment);
        }

        // GET: Manage/Equipments/Delete/5
        public ActionResult Delete(int? id)
        {
            Equipment equipment = db.Equipments.Find(id);
            db.Equipments.Remove(equipment);
            db.SaveChanges();
            return RedirectToAction("Manage-43", "Manage");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
