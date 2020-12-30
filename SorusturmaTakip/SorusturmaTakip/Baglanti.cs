using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Npgsql;

namespace SorusturmaTakip
{
    class Baglanti
    {
        
        public NpgsqlConnection baglanti()
        {
            NpgsqlConnection baglan = new NpgsqlConnection("Server=Localhost; Port=5432; Password=1234;Database=proje;User Id=postgres");
            baglan.Open();
            return baglan;
        }

    }
}
