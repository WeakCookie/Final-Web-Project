using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Final_Project.Filters;
using Final_Project.Models;

namespace Final_Project.Controllers
{
    public class AuthController : Controller
    {

        Model1Container db = new Model1Container();

        // GET: Auth/Login
        public ActionResult Login()
        {
            return View();
        }

        // POST: Auth/Login
        [HttpPost]
        public ActionResult Login(User user)
        {
            try
            {
                var currentUser = db.Users.SingleOrDefault(u => (u.Username == user.Username || u.Email == user.Email) && (u.Password == user.Password));
                if (currentUser != null)
                {
                    Session["loggedIn"] = currentUser.Email;
                    Session["username"] = currentUser.FullName;

                    if (currentUser.IsAdmin == true)
                    {
                        return RedirectToAction("Index", "Admin", new { page = (int?)null });
                    }
                    ViewBag.fullname = currentUser.FullName;
                    return RedirectToAction("Index", "Home", new { page = (int?)null });
                }
                ViewBag.error = "Wrong password and email combination !!!";
                return View();
            }
            catch
            {
                return View();
            }
        }

        // GET: Auth/Register
        public ActionResult Register()
        {
            return View();
        }


        // POST: Auth/Register
        [HttpPost]
        public ActionResult Register(User user)
        {
            var existedEmail = db.Users.SingleOrDefault(u => u.Email == user.Email);
            
            if (existedEmail != null)
            {
                ViewBag.error = "The email you registered is not available";
                return View();
            }

            user.Active = true;
            db.Users.Add(user);
            db.SaveChanges();
            return RedirectToAction("Index", "Home");
        }

        [CustomAuthFilter]
        public ActionResult Logout()
        {
            Session["loggedIn"] = null;
            return RedirectToAction("Index", "Home");
        }
    }

}