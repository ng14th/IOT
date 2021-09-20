using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using System.IO.Ports;
using System.Xml;



namespace GTBNV_EX2_DESO1_NguyenThanhNguyen_18018791
{
    public partial class Form1 : Form
    {
        string ReceiveData = String.Empty;
        string TransmitData = String.Empty;
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            Serial_Port.PortName = "Select COM Port...";
            Serial_Port.BaudRate = 4800;
            Serial_Port.DataBits = 8;
            Serial_Port.Parity = Parity.None;
            Serial_Port.StopBits = StopBits.One;
            string[] ports = SerialPort.GetPortNames();
            foreach (string port in ports)
            {
                comboBox.Items.Add(port);
            }

        }

        private void Form1_FormClosed(object sender, FormClosedEventArgs e)
        {
            if (Serial_Port.IsOpen)
                Serial_Port.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (comboBox.Text == "")
                MessageBox.Show("Select COM Port. ", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            else if (comboBox2.Text == "")
                MessageBox.Show("Select baudrate for COM Port. ", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            else
            {
                try
                {
                    if (Serial_Port.IsOpen)
                    {
                        MessageBox.Show("COM Port is connected and ready for use.", " Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    else
                    {
                        
                        Serial_Port.Open();
                        MessageBox.Show(comboBox.Text + " is connected ", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        textBox4.BackColor = Color.Lime;
                        textBox4.Text = "Connecting...";
                        comboBox.Enabled = false;
                        comboBox2.Enabled = false;
                        ReceiveData = String.Empty;
                        TransmitData = String.Empty;
                        textBox3.Text = "Closed";
                        ovalShape1.BackColor = Color.Green;
                        textBox2.Text = "1";

                    }
                }
                catch (Exception)
                {
                    textBox4.BackColor = Color.Red;
                    textBox4.Text = " Disconnected ";
                    MessageBox.Show("COM Port is not found. Please check your COM or Cable.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

                }
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                if (Serial_Port.IsOpen)
                {
                    Serial_Port.Close();
                    textBox4.BackColor = Color.Red;
                    textBox4.Text = "Disconnected";
                    MessageBox.Show("COM port is disconnected", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    comboBox.Enabled = true;
                    comboBox2.Enabled = true;
                    textBox3.Text = "";
                    ovalShape1.BackColor = Color.DarkGray;
                    textBox1.Text = "0";
                    textBox2.Text = "0";
                    ovalShape2.BackColor = Color.DarkGray;

                }
                else
                {
                    MessageBox.Show("COM port is disconnected. Please reconnect to use", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
            }
            catch (Exception)
            {
                MessageBox.Show("Disconnection appear error.Unable to disconnect.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            DialogResult answer = MessageBox.Show("Do you want to exit the program?", "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (answer == DialogResult.Yes)
            {
                if (Serial_Port.IsOpen)
                {
                    Serial_Port.Close();
                }
                this.Close();
            }
        }

        private void comboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            Serial_Port.Close();
            textBox4.BackColor = Color.Red;
            textBox4.Text = "Disconnected";
            Serial_Port.PortName = comboBox.Text;
        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            Serial_Port.Close();
            textBox4.BackColor = Color.Red;
            textBox4.Text = "Disconnected";
            Serial_Port.BaudRate = Convert.ToInt32(comboBox2.Text);

        }

        private void Serial_Port_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            CheckForIllegalCrossThreadCalls = false;
            ReceiveData = Serial_Port.ReadTo("&");
            if (ReceiveData.Substring(0, 1) == "@")
            {
                if (ReceiveData.Substring(1, 1) == "S")
                {
                    textBox2.Text = ReceiveData.Substring(2);
                    ReceiveData = String.Empty;
                    ovalShape1.BackColor = Color.Green;
                    ovalShape2.BackColor = Color.DarkGray;
                    textBox3.Text = "Closed";
                }
            
            
            
                else if (ReceiveData.Substring(1, 1) == "s")
                {
                    textBox1.Text = ReceiveData.Substring(2);
                    ReceiveData = String.Empty;
                    ovalShape2.BackColor = Color.Red;
                    ovalShape1.BackColor = Color.DarkGray;
                    textBox3.Text = "Openned";
                }
            }
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }
    }
}