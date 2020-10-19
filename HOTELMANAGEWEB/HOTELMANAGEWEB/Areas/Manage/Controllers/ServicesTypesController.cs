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
    public class ServicesTypesController : Controller
    {
        private QLKSWEBEntities db = new QLKSWEBEntities();

        // GET: Manage/ServicesTypes
        public ActionResult Index()
        {
            return View(db.ServicesTypes.ToList());
        }

        // GET: Manage/ServicesTypes/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Manage/ServicesTypes/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ServicesTypeID,ServicesTypeName,Disabled,CreatedUserID,ModifyUserID,DateCreated,DateModify")] ServicesType servicesType)
        {
            if (ModelState.IsValid)
            {
                db.ServicesTypes.Add(servicesType);
                db.SaveChanges();
                return RedirectToAction("Manage-51", "Manage");
            }

            return View(servicesType);
        }

        // GET: Manage/ServicesTypes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ServicesType servicesType = db.ServicesTypes.Find(id);
            if (servicesType == null)
            {
                return HttpNotFound();
            }
            return View(servicesType);
        }

        // POST: Manage/ServicesTypes/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ServicesTypeID,ServicesTypeName,Disabled,CreatedUserID,ModifyUserID,DateCreated,DateModify")] ServicesType servicesType)
        {
            if (ModelState.IsValid)
            {
                db.Entry(servicesType).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Manage-51", "Manage");
            }
            return View(servicesType);
        }

        // GET: Manage/ServicesTypes/Delete/5
        public ActionResult Delete(int? id)
        {
            ServicesType servicesType = db.ServicesTypes.Find(id);
            db.ServicesTypes.Remove(servicesType);
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
