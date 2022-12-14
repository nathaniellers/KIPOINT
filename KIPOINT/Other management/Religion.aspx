<%@ Page Title="Religion" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Religion.aspx.cs" Inherits="KIPOINT.Others" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <style>
         table {
          border-collapse: collapse;
          border-spacing: 0;
        }

        td,
        th {
            padding: 3px;
        }
                
            .auto-style1 {
                height: 22px;
                width: 1428px;
            }
            .auto-style3 {
                width: 1607px;
                height: 21px;
            }
            .auto-style5 {
                height: 22px;
                width: 3365px;
            }
            .auto-style6 {
                height: 22px;
                width: 617px;
            }
            .auto-style7 {
                height: 22px;
                width: 1607px;
            }
                
            .container-fluid{
                margin-top: 50px;
            }
    </style>

    <div class="card pb-3">
        <div class="container-fluid">
           
            <div class="row mb-3 text-center">
                <div class="col-md-8 themed-grid-col">
                       <table style="width: 100%; height: 130px">
                            <tr>
                                <td class="auto-style1">&nbsp;</td>
                                <td style="height: 22px; width: 450px"" colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style1">
                                    Religion Name*</td>
                                <td style="height: 22px; width: 450px"" colspan="2">
                    <asp:TextBox ID="txt_religion" runat="server" Width="250px" Height="25px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style1">&nbsp;</td>
                                <td style="height: 22px; width: 450px"" colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style1">&nbsp;</td>
                                <td class="auto-style6">
                                    <asp:Button ID="btn_submit" runat="server" Height="30px" OnClick="btn_submit_Click" Text="Submit" Width="150px" class="btn btn-success"/>
                                </td>
                                <td style="height: 22px; width: 450px"">
                                    <asp:Button ID="btn_clear" runat="server" Height="30px" OnClick="btn_clear_Click" Text="Clear" Width="150px" class="btn btn-danger" />
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style1">
                    <asp:Label ID="Label1" runat="server"></asp:Label>
                                </td>
                                <td style="height: 22px; width: 450px"" colspan="2">
                                    &nbsp;</td>
                            </tr>
                            </table>
                     </div>

                <div class="col-md-4 themed-grid-col">
                <asp:GridView ID="religion_view" runat="server" DataKeyNames="id"  OnRowDataBound="OnRowDataBound"
                    OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" OnRowUpdating="OnRowUpdating"
                    OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added." AutoGenerateEditButton="True"
                    ShowHeaderWhenEmpty="True" AutoGenerateDeleteButton="True" Width="70%" Height="100px" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" HorizontalAlign="Left">
                        <AlternatingRowStyle BackColor="#CCCCCC" />
                        <Columns>
                            <asp:TemplateField HeaderText="Religion">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txt_religion" runat="server"  Text='<% #Bind("religion_name") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_religion" runat="server" Text='<% #Eval("religion_name") %>'></asp:Label>
                                </ItemTemplate>
                            
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" ForeColor="White" HorizontalAlign="Left" VerticalAlign="Middle" Font-Bold="True" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Left" />
                        <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#808080" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#383838" />
                    </asp:GridView>
                    <br />
                </div>

            </div>




          
                
                
                
              </div>
         </div>
    







</asp:Content>
