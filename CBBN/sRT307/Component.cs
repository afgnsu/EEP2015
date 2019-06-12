using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;
using System.IO;
using Newtonsoft;
using Newtonsoft.Json;
using Srvtools;
using System.Web;

namespace sRT307
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

        public object[] smRT3071(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmd.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                //�|���s��
                string selectSql = @"SELECT KIND, CODE, CODENC FROM RTCode WHERE KIND='S4' AND CODE='1'";
                cmd.CommandText = selectSql;
                DataSet ds = cmd.ExecuteDataSet();
                string P1 = ds.Tables[0].Rows[0]["CODENC"].ToString();
                
                //�ө��N��
                selectSql = @"SELECT KIND, CODE, CODENC FROM RTCode WHERE KIND='S4' AND CODE='2'";
                cmd.CommandText = selectSql;
                ds = cmd.ExecuteDataSet();
                string P2 = ds.Tables[0].Rows[0]["CODENC"].ToString();
                //�o�����ӿ�(S�}�Y)
                /*
                 1�B���ӿ��O(S)�C
                 2�B�ө��ۭq�s���C
                 3�B�o�������CB2C��B2B
                 4�B�R���H�Τ@�s���AB2C���ɭԱa�ŭ�
                 5�B�R���H�W�١C
                 6�B�q�l�H�c�C
                 7�B�R���H�a�}�C
                 8�B�������O�G0�B������X�A1�B�۵M�H�A2�B���I�_����C
                 9�B����s���G��Ȥ�N���C
                 10�B�R�߽X
                 11�B�����ȥ��o���C
                 ---�Ĥ@�氵��o��C
                 12�B�|�O
                 13�B�|�v
                 14�B�P��X�p
                 15�B�|�B
                 16�B�o�����B
                 17�B�Ƶ�
                 */
                selectSql = @"SELECT 'S,'+ PRTNO +','+CASE 
                            WHEN ISNULL(UNINO, '') = '' AND ISNULL(LTRIM(EMAIL), '') = '' THEN 'B2C,,' + CUSNC + ',' + 'invoice@cbbn.com.tw' + ',' + raddr + ',2,' + PICODE + ',,N,'
                            WHEN ISNULL(UNINO, '') = '' THEN 'B2C,,' + CUSNC + ',' + EMAIL + ',' + raddr + ',2,' + PICODE + ',,N,'
                            ELSE 'B2B,' + UNINO + ',' + invtitle + ',' + EMAIL + ',' + raddr + ',,,,Y,' END 
                                        + '1,5,' + Convert(varchar(50), Convert(FLOAT(50), ROUND(AMT / 1.05, 0)))
                                        + ',' + Convert(varchar(50), Convert(FLOAT(50), AMT - ROUND(AMT / 1.05, 0))) + ',' + Convert(varchar(50), Convert(FLOAT(50), AMT))
                                        + ',' + CASE WHEN CODENC = '�H�Υd' THEN '���|�X�G'+RIGHT(CREDITCARDNO, 4) + '�@' ELSE '' END 
                                        + CASE WHEN ISNULL(STRBILLINGDAT, '') <> '' AND ISNULL(DUEDAT, '') <> '' 
                                          THEN CONVERT(VARCHAR(10), ISNULL(STRBILLINGDAT, ''), 111) + '~' + CONVERT(VARCHAR(10), ISNULL(DUEDAT, ''), 111) ELSE '' END AS S1,
                            'I,' + PRTNO + ',' + amtnc + ',' + CAST(QTY AS VARCHAR(10)) + ',��,' + CAST(amt AS VARCHAR(10)) + ',' + CAST(amt AS VARCHAR(10)) AS S2
                            FROM V_RT3071 WHERE AMTNC <> '�O�Ҫ�' and " + sdata[0] + " order  by rcvmoneydat, belongnc, comn, cusnc, amtnc ";
                cmd.CommandText = selectSql;
                ds = cmd.ExecuteDataSet();
                string js = string.Empty;
                if (ds.Tables[0].Rows.Count > 0)
                {
                    DateTime dt = DateTime.Now;
                    var sfile = P2 + "_" + string.Format("{0:yyyyMMdd}", dt)+".txt";

                    FileStream fileStream = new FileStream(@"c:\" + sfile, FileMode.Create);

                    fileStream.Close();   //���O�}�F�n��,���M�|�Q���ΦӵL�k�ק��!!!

                    using (StreamWriter sw = new StreamWriter(@"..\JQWebClient\download\" + sfile))
                    {
                        js = "H,INVO,"+P1+","+P2+"," + string.Format("{0:yyyyMMdd}", DateTime.Now.Date) + "\r\n";
                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            js = js + ds.Tables[0].Rows[i]["S1"].ToString() + "\r\n";
                            if (i+1== ds.Tables[0].Rows.Count)
                                js = js + ds.Tables[0].Rows[i]["S2"].ToString();
                            else
                                js = js + ds.Tables[0].Rows[i]["S2"].ToString() + "\r\n";
                        }
                        // ���g�J����r��� ~
                        sw.Write(js);
                    }
                    return new object[] { 0, sfile };
                }
                else
                {
                    return new object[] { 0, "N" };
                }
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����q�l�o����X,���~�T���G" + ex };
            }
        }
    }
}
