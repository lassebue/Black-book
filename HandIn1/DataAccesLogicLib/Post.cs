using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace DataAccesLogicLib
{
    public class Post
    {
        public double Amount { get; set; }

        public DateTime LoanDate { get; set; }
    
        public DateTime PaymentDate { get; set; }

        public int PostID;
        public int PersonID;

    }
}
