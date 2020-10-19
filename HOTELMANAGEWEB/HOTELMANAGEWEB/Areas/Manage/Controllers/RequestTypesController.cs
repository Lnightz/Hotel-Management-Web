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
    public class RequestTypesController : Controller
    {
        private QLKSWEBEntities db = new QLKSWEBEntities();

        // GET: Manage/RequestTypes
        public ActionResult Index()
        {
            return View(db.RequestTypes.ToList());
        }

        // GET: Manage/RequestTypes/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Manage/RequestTypes/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "RequestTypeID,RequestTypeName,Disabled,CreatedUserID,ModifyUserID,DateCreated,DateModify")] RequestType requestType)
        {
            if (ModelState.IsValid)
            {
                db.RequestTypes.Add(requestType);
                db.SaveChanges();
                return RedirectToAction("Manage-51", "Manage");
            }

            return View(requestType);
        }

        // GET: Manage/RequestTypes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            RequestType requestType = db.RequestTypes.Find(id);
            if (requestType == null)
            {
                return HttpNotFound();
            }
            return View(requestType);
        }

        // POST: Manage/RequestTypes/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "RequestTypeID,RequestTypeName,Disabled,CreatedUserID,ModifyUserID,DateCreated,DateModify")] RequestType requestType)
        {
            if (ModelState.IsValid)
            {
                db.Entry(requestType).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Manage-51", "Manage");
            }
            return View(requestType);
        }

        // GET: Manage/RequestTypes/Delete/5
        public ActionResult Delete(int? id)
        {
            RequestType requestType = db.RequestTypes.Find(id);
            db.RequestTypes.Remove(requestType);
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
