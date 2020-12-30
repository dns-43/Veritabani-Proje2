using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Npgsql;

namespace SorusturmaTakip
{
    public partial class Kisiler : Form
    {
        public Kisiler()
        {
            InitializeComponent();
        }


        Baglanti bgl = new Baglanti();


        void listele()
        {
            //DataSet ds = new DataSet();
            string sorgu = "SELECT kisi.tcno, kisi.adi,kisi.soyadi,kisi.konum, kisi.dtarih, iletisim.numara, adres.adres FROM kisi INNER JOIN iletisim  ON kisi.tcno =iletisim.kisi_id INNER JOIN adres  ON kisi.tcno = adres.kisiid";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sorgu, bgl.baglanti());
            // MessageBox.Show(da.ToString());
            DataTable tablo = new DataTable();
            da.Fill(tablo);
            dataGridView1.DataSource = tablo;
            //bgl.baglanti().Close();


        }
        deneme fr;
        private void button1_Click(object sender, EventArgs e)
        {
            if (fr == null)
            {
                fr = new deneme();

                fr.Show();

            }

        }

        private void Kisiler_Load(object sender, EventArgs e)
        {
            listele();
            
        }

        private void radioSupheli_Click(object sender, EventArgs e)
        {

        }

        private void btnGuncelle_Click(object sender, EventArgs e)
        {
            string sorgu = " UPDATE kisi SET adi=@adi, soyadi=@soyadi, konum=@konum, dtarih=@dtarih WHERE tcno=@tcno";
            NpgsqlCommand komut = new NpgsqlCommand(sorgu, bgl.baglanti());
            komut.Parameters.AddWithValue("@tcno", (txtTCKN.Text));
            komut.Parameters.AddWithValue("@adi", txtName.Text);
            komut.Parameters.AddWithValue("@soyadi", txtSoyadi.Text);
            komut.Parameters.AddWithValue("@dtarih", dateTimePicker1.Value);
             
            if (radioMusteki.Checked)
                komut.Parameters.AddWithValue("@konum", "Müşteki");
            else
            {
                komut.Parameters.AddWithValue("@konum", "Şüpheli");
            }
                
            komut.ExecuteNonQuery();
                   
            string sorgu_iletisim = "UPDATE iletisim SET numara=@numara WHERE kisi_id=@kisi_id";
            NpgsqlCommand komut_iletisim = new NpgsqlCommand(sorgu_iletisim, bgl.baglanti());
            komut_iletisim.Parameters.AddWithValue("@kisi_id", (txtTCKN.Text));
            komut_iletisim.Parameters.AddWithValue("@numara", (txtCep.Text));
            komut_iletisim.ExecuteNonQuery();
            

            
            string sorgu_adres = "UPDATE adres set adres=@adres WHERE kisiid=@kisiid";
            NpgsqlCommand komut_adres = new NpgsqlCommand(sorgu_adres, bgl.baglanti());
            komut_adres.Parameters.AddWithValue("@kisiid", (txtTCKN.Text));
            komut_adres.Parameters.AddWithValue("@adres", (txtAdres.Text));
            komut_adres.ExecuteNonQuery();

            bgl.baglanti().Close();
            MessageBox.Show("Kişiler Güncellendi", "Bilgi", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            listele();
        }

        private void dataGridView1_CellEnter(object sender, DataGridViewCellEventArgs e)
        {
            string konum;
            txtTCKN.Text = dataGridView1.CurrentRow.Cells[0].Value.ToString();
            txtName.Text = dataGridView1.CurrentRow.Cells[1].Value.ToString();
            txtSoyadi.Text = dataGridView1.CurrentRow.Cells[2].Value.ToString();
            dateTimePicker1.Text = dataGridView1.CurrentRow.Cells[4].Value.ToString();
            konum = dataGridView1.CurrentRow.Cells[3].Value.ToString();
            txtCep.Text= dataGridView1.CurrentRow.Cells[5].Value.ToString();
            txtAdres.Text= dataGridView1.CurrentRow.Cells[6].Value.ToString();

            /*if (konum = "Müşteki")
             {
                 radioMusteki.Checked = true;
                 radioSupheli.Checked = false;
             }
             else
             {
                 radioSupheli.Checked = true;
                 radioMusteki.Checked = false;
             } */

        }

        private void btnEkle_Click(object sender, EventArgs e)
        {
            string sorgu = " INSERT INTO kisi(tcno,adi,soyadi,konum,dtarih) VALUES(@tcno,@adi,@soyadi,@konum,@dtarih)";
            NpgsqlCommand komut = new NpgsqlCommand(sorgu, bgl.baglanti());
            komut.Parameters.AddWithValue("@tcno", txtTCKN.Text);
            komut.Parameters.AddWithValue("@adi", txtName.Text);
            komut.Parameters.AddWithValue("@soyadi", txtSoyadi.Text);
            komut.Parameters.AddWithValue("@dtarih", dateTimePicker1.Value);

            if (radioMusteki.Checked)
                komut.Parameters.AddWithValue("@konum", "Müşteki");
            else
                komut.Parameters.AddWithValue("@konum", "Şüpheli");
            komut.ExecuteNonQuery();

            string sorgu_adres = "INSERT INTO adres(kisiid,adres) VALUES (@kisiid,@adres)";
            NpgsqlCommand komut_adres = new NpgsqlCommand(sorgu_adres, bgl.baglanti());
            komut_adres.Parameters.AddWithValue("@kisiid", txtTCKN.Text);
            komut_adres.Parameters.AddWithValue("@adres", txtAdres.Text);
            komut_adres.ExecuteNonQuery();

            string sorgu_iletisim = "INSERT INTO iletisim(kisi_id,numara) VALUES(@kisi_id,@numara)";
            NpgsqlCommand komut_iletisim = new NpgsqlCommand(sorgu_iletisim, bgl.baglanti());
            komut_iletisim.Parameters.AddWithValue("@kisi_id", txtTCKN.Text);
            komut_iletisim.Parameters.AddWithValue("@numara", txtCep.Text);
            komut_iletisim.ExecuteNonQuery();

            bgl.baglanti().Close();
            MessageBox.Show("Kişiler Eklendi", "Bilgi", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            listele();
        }

        private void btnSil_Click(object sender, EventArgs e)
        {
            string sorgu = "DELETE FROM  kisi WHERE tcno=@tcno";
            NpgsqlCommand komut = new NpgsqlCommand(sorgu, bgl.baglanti());
            komut.Parameters.AddWithValue("@tcno",(txtTCKN.Text));
           /// bgl.baglanti().Open();
            komut.ExecuteNonQuery();

            string sorgu_adres = "DELETE FROM adres WHERE kisiid=@kisiid";
            NpgsqlCommand komut_adres = new NpgsqlCommand(sorgu_adres, bgl.baglanti());
            komut_adres.Parameters.AddWithValue("@kisiid", (txtTCKN.Text));
            komut_adres.ExecuteNonQuery();

            string sorgu_iletisim = "DELETE FROM iletisim WHERE kisi_id=@kisi_id";
            NpgsqlCommand komut_iletisim = new NpgsqlCommand(sorgu_iletisim, bgl.baglanti());
            komut_iletisim.Parameters.AddWithValue("@kisi_id", (txtTCKN.Text));
            komut_iletisim.ExecuteNonQuery();


            MessageBox.Show("Kişi  ve Kişi bilgileri Silindi", "Bilgi", MessageBoxButtons.OK, MessageBoxIcon.Warning);

            bgl.baglanti().Close();
            listele();



        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void btnListele_Click(object sender, EventArgs e)
        {
            string sorgu = "SELECT * FROM kisi WHERE tcno=@tcno";
            NpgsqlCommand komut = new NpgsqlCommand(sorgu, bgl.baglanti());
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sorgu, bgl.baglanti());
            komut.Parameters.AddWithValue("@tcno", (txtTCKN.Text));
            DataTable tablo = new DataTable();
            da.Fill(tablo);
            dataGridView1.DataSource = tablo;
            da.ExecuteNonQuery();

            listele();




        }
    }
}
