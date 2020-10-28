using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using HOTELMANAGEWEB.BLL;
using HOTELMANAGEWEB.Models;

namespace HOTELMANAGEWEB.Areas.Manage.Controllers
{
    public class PromotionsController : Controller
    {
        private QLKSWEBEntities db = new QLKSWEBEntities();

        // GET: Manage/Promotions
        public ActionResult Index()
        {
            var promotions = db.Promotions.Include(p => p.Account);
            return View(promotions.ToList());
        }

        // GET: Manage/Promotions/Create
        public ActionResult Create()
        {
            ViewBag.CreatedUserID = new SelectList(db.Accounts, "AccountID", "UserName");
            return View();
        }

        // POST: Manage/Promotions/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "PromotionID,PromotionName,PercentDiscount,PromotionContent,CreatedUserID,ModifyUserID,DateCreated,DateModify")] Promotion promotion)
        {
            if (ModelState.IsValid)
            {
                var account = ManageBLL.Instance.GetUserByUserName(User.Identity.Name);
                promotion.CreatedUserID = account.AccountID;
                db.Promotions.Add(promotion);
                db.SaveChanges();
                return RedirectToAction("Manage-55", "Manage");
            }

            ViewBag.CreatedUserID = new SelectList(db.Accounts, "AccountID", "UserName", promotion.CreatedUserID);
            return View(promotion);
        }

        // GET: Manage/Promotions/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Promotion promotion = db.Promotions.Find(id);
            if (promotion == null)
            {
                return HttpNotFound();
            }
            ViewBag.CreatedUserID = new SelectList(db.Accounts, "AccountID", "UserName", promotion.CreatedUserID);
            return View(promotion);
        }

        // POST: Manage/Promotions/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "PromotionID,PromotionName,PercentDiscount,PromotionContent,CreatedUserID,ModifyUserID,DateCreated,DateModify")] Promotion promotion)
        {
            if (ModelState.IsValid)
            {
                var account = ManageBLL.Instance.GetUserByUserName(User.Identity.Name);
                promotion.ModifyUserID = account.AccountID;
                db.Entry(promotion).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Manage-55", "Manage");
            }
            ViewBag.CreatedUserID = new SelectList(db.Accounts, "AccountID", "UserName", promotion.CreatedUserID);
            return View(promotion);
        }

        // GET: Manage/Promotions/Delete/5
        public ActionResult Delete(int? id)
        {
            Promotion promotion = db.Promotions.Find(id);
            db.Promotions.Remove(promotion);
            db.SaveChanges();
            return RedirectToAction("Manage-55", "Manage");
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
