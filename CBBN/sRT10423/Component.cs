using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;

namespace sRT10423
{
    public partial class Component : DataModule
    {
        public Component()
        {
            InitializeComponent();
        }

        public Component(IContainer container)
        {
            container.Add(this);

            InitializeComponent();
        }

        public object[] smRT104231(object[] objParam)
        {
            //�ફ�~��γ�@�~
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT104231.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT104231.InfoParameters[0].Value = sdata[0];
                cmdRT104231.InfoParameters[1].Value = sdata[1];
                cmdRT104231.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT104231.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }

        }

        public object[] smRT104232(object[] objParam)
        {
            //�ફ�~��γ�@�~
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT104232.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT104232.InfoParameters[0].Value = sdata[0];
                cmdRT104232.InfoParameters[1].Value = sdata[1];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT104232.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }

        }
    }
}
