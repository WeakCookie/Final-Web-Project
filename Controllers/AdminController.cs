using Final_Project.Filters;
using Final_Project.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Final_Project.Controllers
{
    [CustomAuthFilterAdmin]
    public class AdminController : Controller
    {
        Model1Container db = new Model1Container();
        // GET: Admin
        public ActionResult Index()
        {
            return View(db.Products.ToList());
        }
    }
}