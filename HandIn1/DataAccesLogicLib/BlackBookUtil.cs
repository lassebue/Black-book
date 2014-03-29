using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace DataAccesLogicLib
{
    public class BlackBookUtil
    {
        private SqlConnection conn;


        public BlackBookUtil()
        {
            // Instantiate the connection

            conn =
                new SqlConnection(
                    @" Data Source=webhotel10.iha.dk;Initial Catalog=F14I4DABH0Gr2;Persist Security Info=True;User ID=F14I4DABH0Gr2;Password=F14I4DABH0Gr2");
           
        }

        public void InsertPerson(Person person)
        {
            try
            {
                // Open theconnection
                conn.Open();

                string insertString = @"
                   INSERT INTO PersonSb (PersonID,FirstName,SirName)
                   VALUES (4, N'Tom', N'Tomsen')
                   GO
                   SELECT SCOPE_IDENTITY()
                   GO";

                // prepare command string using paramters in string and returning the given identity

                string insertStringParam = @"INSERT INTO [PersonSb] (PersonID,FirstName,SirName)
                                                    OUTPUT INSERTED.PersonID  
                                                    VALUES (@Data1, @Data2,@Data3)";
                //Alternative //    ; SELECT SCOPE_IDENTITY()";


                using (SqlCommand cmd = new SqlCommand(insertStringParam, conn))
                {
                    // Get your parameters ready 
                    cmd.Parameters.Add(cmd.CreateParameter()).ParameterName = "@Data1";
                    cmd.Parameters.Add(cmd.CreateParameter()).ParameterName = "@Data2";
                    cmd.Parameters.Add(cmd.CreateParameter()).ParameterName = "@Data3";
                    cmd.Parameters["@Data1"].Value = person.id; //.ToString("yyyy-MM-dd HH:mm:ss"); ;
                    cmd.Parameters["@Data2"].Value = person.FName;
                    cmd.Parameters["@Data3"].Value = person.SName;

                    //var id 
                    person.id = (int) cmd.ExecuteScalar(); //Returns the identity of the new tuple/record

                    //cmd.ExecuteNonQuery(); //Does not workReturns row affected and not the identity of the new tuple/record

                    //this.locPerson = person; //Make new Person to currentPerson

                }


            }
            finally
            {
                // Close the connection
                if (conn != null)
                {
                    conn.Close();
                }
            }
        }





        public void InsertPost(Post post)
        {
            try
            {
                // Open the connection
                conn.Open();

                string insertString = @"
                   INSERT INTO Post (PostID,LoanDate,PaymentDate,PersonID,Amount)
                   VALUES (5, '10-11-2013','11-11-2013',1,200)
                   GO
                   SELECT SCOPE_IDENTITY()
                   GO";

                // prepare command string using paramters in string and returning the given identity

                string insertStringParam = @"INSERT INTO [Post] (PostID,LoanDate,PaymentDate,PersonID,Amount)
                                                    OUTPUT INSERTED.PostID  
                                                    VALUES (@Data1, @Data2,@Data3,@Data4,@Data5)";
                //Alternative //    ; SELECT SCOPE_IDENTITY()";


                using (SqlCommand cmd = new SqlCommand(insertStringParam, conn))
                {
                    // Get your parameters ready 
                    cmd.Parameters.Add(cmd.CreateParameter()).ParameterName = "@data1";
                    cmd.Parameters.Add(cmd.CreateParameter()).ParameterName = "@data2";
                    cmd.Parameters.Add(cmd.CreateParameter()).ParameterName = "@data3";
                    cmd.Parameters.Add(cmd.CreateParameter()).ParameterName = "@data4";
                    cmd.Parameters.Add(cmd.CreateParameter()).ParameterName = "@data5";
                    cmd.Parameters["@Data1"].Value = post.PostID; //.ToString("yyyy-MM-dd HH:mm:ss"); ;
                    cmd.Parameters["@Data2"].Value = post.LoanDate;
                    cmd.Parameters["@Data3"].Value = post.PaymentDate;
                    cmd.Parameters["@Data4"].Value = post.PersonID;
                    cmd.Parameters["@Data5"].Value = post.Amount;
                    //var id 
                    post.PostID = (int) cmd.ExecuteScalar(); //Returns the identity of the new tuple/record

                    //hv.HID = (int)cmd.ExecuteNonQuery(); //Does not workReturns row affected and not the identity of the new tuple/record

                    //this.locPost = post; //Make new Post to currentPost

                }


            }
            finally
            {
                // Close the connection
                if (conn != null)
                {
                    conn.Close();
                }
            }
        }



        public void DeletePerson(Person person)
        {
            try
            {
                // Open the connection
                conn.Open();

                string DeletePerson =
                    @"DELETE FROM PersonSb
                        WHERE (PersonID = @Data1)";
                

                // prepare command string using paramters in string and returning the given identity

                string deleteString = @"delete from PersonSb where PersonID = @Data1";
                //Alternative //    ; SELECT SCOPE_IDENTITY()";


                using (SqlCommand cmd = new SqlCommand(deleteString, conn))
                {
                    // Get your parameters ready 
                    cmd.Parameters.Add(cmd.CreateParameter()).ParameterName = "@data1";
                    cmd.Parameters["@Data1"].Value = person.id;
                    var id = (int)cmd.ExecuteNonQuery(); //har ikke forstået den linie??


                }


            }
            finally
            {
                // Close the connection
                if (conn != null)
                {
                    conn.Close();
                }
            }


        }






        public void DeletePost(Post post)
        {
            try
            {
                // Open the connection
                conn.Open();

          

                // prepare command string using paramters in string and returning the given identity

                string deleteStringParam = @"delete from Post where PostID = @Data1";
                //Alternative //    ; SELECT SCOPE_IDENTITY()";


                using (SqlCommand cmd = new SqlCommand(deleteStringParam, conn))
                {
                    // Get your parameters ready 
                    cmd.Parameters.Add(cmd.CreateParameter()).ParameterName = "@data1";
                    cmd.Parameters["@Data1"].Value = post.PostID;
                       
                    var id = (int)cmd.ExecuteNonQuery(); //har ikke forstået den linie??
         
                
                }


            }
            finally
            {
                // Close the connection
                if (conn != null)
                {
                    conn.Close();
                }
            }
            
        }
        
        
    }
}
