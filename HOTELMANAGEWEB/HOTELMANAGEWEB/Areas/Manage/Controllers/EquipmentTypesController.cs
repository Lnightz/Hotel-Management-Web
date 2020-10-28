using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using HOTELMANAGEWEB.Models;
using HOTELMANAGEWEB.BLL;

namespace HOTELMANAGEWEB.Areas.Manage.Controllers
{
    public class EquipmentTypesController : Controller
    {
        private QLKSWEBEntities db = new QLKSWEBEntities();

        // GET: Manage/EquipmentTypes
        public ActionResult Index()
        {
            return View(db.EquipmentTypes.ToList());
        }    

        // GET: Manage/EquipmentTypes/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Manage/EquipmentTypes/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "EquipmentTypeID,EquipmentTypeName,Disabled,CreatedUserID,ModifyUserID,DateCreated,DateModify")] EquipmentType equipmentType)
        {
            if (ModelState.IsValid)
            {
                var account = ManageBLL.Instance.GetUserByUserName(User.Identity.Name);
                equipmentType.CreatedUserID = account.AccountID;
                db.EquipmentTypes.Add(equipmentType);
                db.SaveChanges();
                return RedirectToAction("Manage-51", "Manage");
            }

            return View(equipmentType);
        }

        // GET: Manage/EquipmentTypes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EquipmentType equipmentType = db.EquipmentTypes.Find(id);
            if (equipmentType == null)
            {
                return HttpNotFound();
            }
            return View(equipmentType);
        }

        // POST: Manage/EquipmentTypes/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "EquipmentTypeID,EquipmentTypeName,Disabled,CreatedUserID,ModifyUserID,DateCreated,DateModify")] EquipmentType equipmentType)
        {
            if (ModelState.IsValid)
            {
                var account = ManageBLL.Instance.GetUserByUserName(User.Identity.Name);
                equipmentType.ModifyUserID = account.AccountID;
                db.Entry(equipmentType).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Manage-51", "Manage");
            }
            return View(equipmentType);
        }

        // GET: Manage/EquipmentTypes/Delete/5
        public ActionResult Delete(int? id)
        {
            EquipmentType equipmentType = db.EquipmentTypes.Find(id);
            db.EquipmentTypes.Remove(equipmentType);
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
