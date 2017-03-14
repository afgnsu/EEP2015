using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Srvtools;

public partial class Template_JQueryQuery1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public override void ProcessRequest(HttpContext context)
    {
        if (context.Request.Form["mode"] == "getFile")   //�B�J1���w�q����
        {
            ButtonDownloadFile("C:\\EEP2015\\JQWebClient\\download\\334.20170310");
        }
        else if (!JqHttpHandler.ProcessRequest(context))
        {
            base.ProcessRequest(context);
        }
    }

    protected void ButtonDownloadFile(string xFile)
    {

        /*
        string srv_file = "C:\\EEP2015\\JQWebClient\\download\\334.20170310";
        string cli_file = "C:\\334.20170310";
        if (File.Exists(srv_file))
            CliUtils.DownLoad(srv_file, cli_file);
        */

        /*
        string filename = "C:\\EEP2015\\JQWebClient\\download\\334.20170310";
        string saveFileName = "c:\\MyFolder\\334.20170310";
        int intStart = filename.LastIndexOf("\\") + 1;
        saveFileName = filename.Substring(intStart, filename.Length - intStart);


        System.IO.FileInfo fi = new System.IO.FileInfo(filename);
        string fileextname = fi.Extension;
        string DEFAULT_CONTENT_TYPE = "application/unknow";
        Microsoft.Win32.RegistryKey regkey, fileextkey;
        string filecontenttype;
        try
        {
            regkey = Microsoft.Win32.Registry.ClassesRoot;
            fileextkey = regkey.OpenSubKey(fileextname);
            filecontenttype = fileextkey.GetValue("Content Type", DEFAULT_CONTENT_TYPE).ToString();
        }
        catch
        {
            filecontenttype = DEFAULT_CONTENT_TYPE;
        }
        Response.Clear();
        Response.Charset = "utf-8";
        Response.Buffer = true;
        this.EnableViewState = false;
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        Response.AppendHeader("Content-Disposition", "attachment;filename=" + saveFileName);
        Response.ContentType = filecontenttype;
        Response.WriteFile(filename);
        Response.Flush();
        Response.Close();
        Response.End();
        */

        /*
        //�Τ�ݪ�����
        string fileUrlPath = "C:\\EEP2015\\JQWebClient\\download\\334.20170310";
        //string cli_file = "C:\\334.20170310";
        System.Net.WebClient wc = new System.Net.WebClient();
        byte[] file = null;

        try
        {
            //�Τ�ݤU���ɮר�byte�}�C
            file = wc.DownloadData(fileUrlPath);
        }
        catch (Exception ex)
        {
            HttpContext.Current.Response.Write("ASP.net�T��U�����ӷP�ɮ�(�q�`���G.cs�B.vb�B�L�n��Ʈwmdb�Bmdf�Mconfig�պA�ɵ�)�C<br/>�ɮ׸��|�G" + fileUrlPath + "<br/>���~�T���G" + ex.ToString());
            return;
        }

        HttpContext.Current.Response.Clear();
        string fileName = System.IO.Path.GetFileName(fileUrlPath);
        //���X�����A���Τ�ݿ�ܭn�x�s���a��                         //�ϥ�Server.UrlEncode()�s�X����r�~���|�U���ɡA�ɦW���ýX
        HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + HttpContext.Current.Server.UrlEncode(fileName));
        //�]�wMIME�������G�i���ɮ�
        HttpContext.Current.Response.ContentType = "application/octet-stream";

        try
        {
            //�ɮצ��U���U�ˡA�ҥH��BinaryWrite
            HttpContext.Current.Response.BinaryWrite(file);

        }
        catch (Exception ex)
        {
            HttpContext.Current.Response.Write("�ɮ׿�X���~�A�z�i�H�b�s������URL���}�K�W�H�U���|���լݬݡC<br/>�ɮ׸��|�G" + fileUrlPath + "<br/>���~�T���G" + ex.ToString());
            return;
        }

        //�o�O�M���g��r��
        //HttpContext.Current.Response.Write();
        HttpContext.Current.Response.End();
        */


        var out_file = xFile;
        if (File.Exists(xFile))
        {
            try
            {
                FileInfo xpath_file = new FileInfo(xFile);  //�n using System.IO;
                                                            // �N�ǤJ���ɦW�H FileInfo �Ӷi��ѪR�]�u�H�r��L�k���^
                System.Web.HttpContext.Current.Response.Clear(); //�M��buffer
                System.Web.HttpContext.Current.Response.ClearHeaders(); //�M��buffer ���Y
                System.Web.HttpContext.Current.Response.Buffer = false;
                System.Web.HttpContext.Current.Response.ContentType = "text/plain";
                // �ɮ������٦��U�C�X��"application/pdf"�B"application/vnd.ms-excel"�B"text/xml"�B"text/HTML"�B"image/JPEG"�B"image/GIF"
                System.Web.HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment;filename=" + System.Web.HttpUtility.UrlEncode(out_file, System.Text.Encoding.UTF8));
                // �Ҽ{ utf-8 �ɦW���D�A�H out_file �]�w�t�s���ɦW
                System.Web.HttpContext.Current.Response.AppendHeader("Content-Length", xpath_file.Length.ToString()); //���Y�[�J�ɮפj�p
                System.Web.HttpContext.Current.Response.WriteFile(xpath_file.FullName);

                // �N�ɮ׿�X
                System.Web.HttpContext.Current.Response.Flush();
                // �j�� Flush buffer ���e
                System.Web.HttpContext.Current.Response.End();
                //return true;

            }
            catch (Exception)
            { 
                //return false; 
            }
        }
        else
        {
                //return false;
        }
    }
}