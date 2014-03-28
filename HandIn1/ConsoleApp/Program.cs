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
            Person abe = new Person();

            abe.FName = "Parsa";
            abe.SName = "Yousefi";
            abe.id = 30;
            BlackBookUtil blackBook = new BlackBookUtil();
            blackBook.insertPerson(abe);
        }
    }
}
