using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccesLogicLib;

namespace ConsoleApp
{
    class Program
    {
        static void Main(string[] args)
        {
            Person person = new Person();
            Post post =new Post();

           person.FName = "Parsa";
           person.SName = "Yousefi";
            person.id = 10;
            BlackBookUtil blackBook = new BlackBookUtil();
            //blackBook.InsertPerson(p);
            person.id = 10;
            blackBook.DeletePerson(person);

            post.PostID = 2;
            post.LoanDate = new DateTime(2014,02,23); 
            post.PaymentDate=new DateTime(2014,03,10);
            post.PersonID = 10;
            post.Amount = 320.76;
          
          //  blackBook.InsertPost(post);



        }
    }
}
