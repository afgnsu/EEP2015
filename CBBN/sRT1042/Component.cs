using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;

namespace sRT1042
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

        public string getFix()
        {
            return string.Format("E{0:yyMMdd}", DateTime.Now.Date);
        }

        public object[] smRT10421(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //開啟資料連接
            IDbConnection conn = cmdRT10421.Connection;
            conn.Open();
            //設定輸入參數的值
            try
            {
                cmdRT10421.InfoParameters[0].Value = sdata[0];
                cmdRT10421.InfoParameters[1].Value = sdata[1];
                cmdRT10421.InfoParameters[2].Value = sdata[2];
                cmdRT10421.InfoParameters[3].Value = sdata[3];
                cmdRT10421.InfoParameters[4].Value = sdata[4];
                cmdRT10421.InfoParameters[5].Value = sdata[5];
                cmdRT10421.InfoParameters[6].Value = sdata[6];
                /*取得統計的結果，並將結果返回*/
                double ii = cmdRT10421.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }
        }

        public object[] smRT10422(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //開啟資料連接
            IDbConnection conn = cmdRT10422.Connection;
            conn.Open();
            //設定輸入參數的值
            try
            {
                cmdRT10422.InfoParameters[0].Value = sdata[0];
                cmdRT10422.InfoParameters[1].Value = sdata[1];
                cmdRT10422.InfoParameters[2].Value = sdata[2];
                /*取得統計的結果，並將結果返回*/
                double ii = cmdRT10422.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }
        }

        public object[] smRT10423(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //開啟資料連接
            IDbConnection conn = cmdRT10423.Connection;
            conn.Open();
            //設定輸入參數的值
            try
            {
                cmdRT10423.InfoParameters[0].Value = sdata[0];
                cmdRT10423.InfoParameters[1].Value = sdata[1];
                cmdRT10423.InfoParameters[2].Value = sdata[2];
                cmdRT10423.InfoParameters[3].Value = sdata[3];
                /*取得統計的結果，並將結果返回*/
                double ii = cmdRT10423.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }
        }

        public object[] smRT10424(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //開啟資料連接
            IDbConnection conn = cmdRT10424.Connection;
            conn.Open();
            //設定輸入參數的值
            try
            {
                cmdRT10424.InfoParameters[0].Value = sdata[0];
                cmdRT10424.InfoParameters[1].Value = sdata[1];
                cmdRT10424.InfoParameters[2].Value = sdata[2];
                /*取得統計的結果，並將結果返回*/
                double ii = cmdRT10424.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }
        }

        public object[] smRT10425(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //開啟資料連接
            IDbConnection conn = cmdRT10425.Connection;
            conn.Open();
            //設定輸入參數的值
            try
            {
                cmdRT10425.InfoParameters[0].Value = sdata[0];
                cmdRT10425.InfoParameters[1].Value = sdata[1];
                cmdRT10425.InfoParameters[2].Value = sdata[2];
                /*取得統計的結果，並將結果返回*/
                double ii = cmdRT10425.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }
        }
    }
}
