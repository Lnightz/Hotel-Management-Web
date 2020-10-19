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
    public class RoomTypesController : Controller
    {
        private QLKSWEBEntities db = new QLKSWEBEntities();

        // GET: Manage/RoomTypes
        public ActionResult Index()
        {
            return View(db.RoomTypes.ToList());
        }

        // GET: Manage/RoomTypes/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Manage/RoomTypes/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "RoomTypeID,RoomTypeName,RoomTypePrices,RoomTypeDescription,Disabled,CreatedUserID,ModifyUserID,DateCreated,DateModify,IsPay,IsShowHomePage,IsShow,RoomTypeImage")] RoomType roomType)
        {
            if (ModelState.IsValid)
            {
                db.RoomTypes.Add(roomType);
                db.SaveChanges();
                return RedirectToAction("Manage-51", "Manage");
            }

            return View(roomType);
        }

        // GET: Manage/RoomTypes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            RoomType roomType = db.RoomTypes.Find(id);
            if (roomType == null)
            {
                return HttpNotFound();
            }
            return View(roomType);
        }

        // POST: Manage/RoomTypes/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "RoomTypeID,RoomTypeName,RoomTypePrices,RoomTypeDescription,Disabled,CreatedUserID,ModifyUserID,DateCreated,DateModify,IsPay,IsShowHomePage,IsShow,RoomTypeImage")] RoomType roomType)
        {
            if (ModelState.IsValid)
            {
                db.Entry(roomType).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Manage-51", "Manage");
            }
            return View(roomType);
        }

        // GET: Manage/RoomTypes/Delete/5
        public ActionResult Delete(int? id)
        {
            RoomType roomType = db.RoomTypes.Find(id);
            db.RoomTypes.Remove(roomType);
            db.SaveChanges();
            return RedirectToAction("Manage-51", "Manage");
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
