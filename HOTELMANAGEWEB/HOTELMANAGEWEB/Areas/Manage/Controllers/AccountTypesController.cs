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
    public class AccountTypesController : Controller
    {
        private QLKSWEBEntities db = new QLKSWEBEntities();

        // GET: Manage/AccountTypes
        public ActionResult Index()
        {
            return View(db.AccountTypes.ToList());
        }

        // GET: Manage/AccountTypes/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Manage/AccountTypes/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "AccountTypeID,AccountTypeName,Disabled")] AccountType accountType)
        {
            if (ModelState.IsValid)
            {
                db.AccountTypes.Add(accountType);
                db.SaveChanges();
                return RedirectToAction("Manage-51", "Manage");
            }

            return View(accountType);
        }

        // GET: Manage/AccountTypes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AccountType accountType = db.AccountTypes.Find(id);
            if (accountType == null)
            {
                return HttpNotFound();
            }
            return View(accountType);
        }

        // POST: Manage/AccountTypes/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "AccountTypeID,AccountTypeName,Disabled")] AccountType accountType)
        {
            if (ModelState.IsValid)
            {
                db.Entry(accountType).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Manage-51", "Manage");
            }
            return View(accountType);
        }

        // GET: Manage/AccountTypes/Delete/5
        public ActionResult Delete(int? id)
        {
            AccountType accountType = db.AccountTypes.Find(id);
            db.AccountTypes.Remove(accountType);
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
