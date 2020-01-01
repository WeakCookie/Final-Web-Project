using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Final_Project.Models;

namespace Final_Project.Controllers
{
    public class Products1Controller : Controller
    {
        private Model1Container db = new Model1Container();

        public ActionResult Cart()
        {
            return View();
        }

        [HttpPost]
        [Route("Cart/{stringId}")]
        public ActionResult Cart(string stringIds)
        {
            char[] spearator = { '-' };
            string[] strlist = stringIds.Split(spearator,StringSplitOptions.RemoveEmptyEntries);
            int[] intIds = { };
            for(var i = 0; i < stringIds.Length; i++)
            {
                intIds[i] = (int)stringIds[i];
            }
            var products = db.Products.Where(p => intIds.Contains(p.Id));
            return View(products.ToList());
        }


        // GET: Products1
        public ActionResult Index()
        {
            string query = "SELECT *" + "FROM Products";
            IEnumerable<Product> data = db.Database.SqlQuery<Product>(query);
            return View(data.ToList());
        }

        // GET: Products1/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // GET: Products1/Create
        public ActionResult Create()
        {
            ViewBag.OrderId = new SelectList(db.Orders, "Id", "Status");
            ViewBag.Categories =
              new SelectList(
                  db.Categories.Select(c => new { Text = c.Name, Value = c.Id }).ToList()
                  , "Value"
                  , "Text");
            return View();
        }

        // POST: Products1/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(ProductViewModel productViewModel, HttpPostedFileBase rawImg)
        {
            if (ModelState.IsValid)
            {
                var newProduct = new Product();

                if (rawImg != null)
                {
                    string relativePath = "/products/" + DateTime.Now.Ticks.ToString() + "_" + rawImg.FileName;
                    string physicalPath = Server.MapPath(relativePath);

                    string imageFolder = Path.GetDirectoryName(physicalPath);
                    if (!Directory.Exists(imageFolder))
                    {
                        Directory.CreateDirectory(imageFolder);
                    }

                    rawImg.SaveAs(physicalPath);
                    productViewModel.ProImagePath = relativePath;
                }

                productViewModel.ProId = int.Parse(Session["UserID"].ToString());
                productViewModel.UpdateProduct(newProduct);

                //always check if the object null before usage
                if (productViewModel.Id != null)
                {
                    foreach (var cID in productViewModel.Id)
                    {
                        var category = db.Categories.Find(cID);
                        if (category != null)
                        {
                            newProduct.Categories.Add(category);
                        }
                    }
                }

                productViewModel.ProActive = true;
                db.Products.Add(newProduct);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.OrderId = new SelectList(db.Orders, "Id", "Status", productViewModel.ProOrderId);
            return View(productViewModel);
        }

        // GET: Products1/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            ViewBag.Categories =
             new SelectList(
                 db.Categories.Select(c => new { Text = c.Name, Value = c.Id }).ToList()
                 , "Value"
                 , "Text");
            ProductViewModel productViewModel = new ProductViewModel(product);
            ViewBag.OrderId = new SelectList(db.Orders, "Id", "Status", productViewModel.ProOrderId);
            return View(productViewModel);
        }

        // POST: Products1/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(ProductViewModel productViewModel, HttpPostedFileBase rawImg)
        {
            if (ModelState.IsValid)
            {
                var newProduct = db.Products.Find(productViewModel.ProId);
                if (newProduct == null)
                {
                    return HttpNotFound();
                }


                if (rawImg != null)
                {
                    string relativePath = "/products/" + DateTime.Now.Ticks.ToString() + "_" + rawImg.FileName;
                    string physicalPath = Server.MapPath(relativePath);

                    string imageFolder = Path.GetDirectoryName(physicalPath);
                    if (!Directory.Exists(imageFolder))
                    {
                        Directory.CreateDirectory(imageFolder);
                    }

                    rawImg.SaveAs(physicalPath);
                    productViewModel.ProImagePath = relativePath;
                }

                productViewModel.ProId = int.Parse(Session["UserID"].ToString());
                productViewModel.UpdateProduct(newProduct);

                //always check if the object null before usage
                if (productViewModel.Id != null)
                {
                    foreach (var cID in productViewModel.Id)
                    {
                        var category = db.Categories.Find(cID);
                        if (category != null)
                        {
                            newProduct.Categories.Add(category);
                        }
                    }
                }

                productViewModel.ProActive = true;
                db.Products.Add(newProduct);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.OrderId = new SelectList(db.Orders, "Id", "Status", productViewModel.ProOrderId);
            return View(productViewModel);
        }

        // GET: Products1/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // POST: Products1/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Product product = db.Products.Find(id);
            db.Products.Remove(product);
            db.SaveChanges();
            return RedirectToAction("Index");
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
