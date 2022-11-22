<%@ Page Title="Equipment" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Equipment.aspx.cs" Inherits="KIPOINT.Equipment" %>
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
        .auto-style12 {
            height: 22px;
            }
        .auto-style14 {
            height: 22px;
            }
            
        .auto-style16 {
            width: 450px;
            height: 22px;
        }
        .auto-style17 {
            width: 449px;
            height: 22px;
        }
    
    </style>

   <div class="card pb-3">
        <div class="container-fluid">
    
            <div class="card-card-header">
                
                <div class="card-card-header">
                    <table style="width: 100%; height: 130px">
                        <tr>
                            <td class="auto-style17">&nbsp;</td>
                            <td class="auto-style14">&nbsp;</td>
                            <td class="auto-style12" colspan="2">&nbsp;</td>
                            <td style="height: 22px; width: 450px"">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style17"></td>
            <td class="auto-style14">
                Equipment Name*</td>
                            <td class="auto-style12" colspan="2">
                <asp:TextBox ID="txt_equipment" runat="server" Height="25px" Width="301px"></asp:TextBox>
                            </td>
                            <td class="auto-style16"></td>
                        </tr>
                        <tr>
                            <td class="auto-style17">&nbsp;</td>
            <td class="auto-style14">
                Equipment no*</td>
                            <td class="auto-style12" colspan="2">
                <asp:TextBox ID="txt_eq_num" runat="server" Height="25px" Width="301px"></asp:TextBox>
                            </td>
                            <td class="auto-style12">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style17">&nbsp;</td>
            <td class="auto-style14">
                Brand*</td>
                            <td class="auto-style12" colspan="2">
                <asp:TextBox ID="txt_brand" runat="server" Height="25px" Width="301px"></asp:TextBox>
                            </td>
                            <td class="auto-style12">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style17"></td>
            <td class="auto-style14" colspan="3">
                <asp:Label ID="Label1" runat="server"></asp:Label>
            </td>
                            <td class="auto-style12">
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style17">&nbsp;</td>
                            <td class="auto-style14">&nbsp;</td>
                            <td class="auto-style12" colspan="2">&nbsp;</td>
                            <td style="height: 22px; width: 450px"">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style17"></td>
                            <td class="auto-style14">&nbsp;</td>
                            <td class="auto-style12">
                <asp:Button ID="btn_submit" runat="server" Text="Submit" Width="150px" OnClick="btn_submit_Click" class="btn btn-success"/>
                            </td>
                            <td class="auto-style12">
                <asp:Button ID="btn_clear" runat="server" Text="Clear" Width="150px" OnClick="btn_clear_Click" class="btn btn-danger"/>
                            </td>
                            <td class="auto-style16"></td>
                        </tr>
                        <tr>
                            <td class="auto-style17">&nbsp;</td>
                            <td class="auto-style14">&nbsp;</td>
                            <td class="auto-style12" colspan="2">&nbsp;</td>
                            <td style="height: 22px; width: 450px"">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style17">&nbsp;</td>
                            <td colspan="3" rowspan="5">
                <asp:GridView ID="equipment_view" runat="server" DataKeyNames="id"  OnRowDataBound="OnRowDataBound_venue"
                OnRowEditing="OnRowEditing_venue" OnRowCancelingEdit="OnRowCancelingEdit_venue" OnRowUpdating="OnRowUpdating_venue"
                OnRowDeleting="OnRowDeleting_venue" EmptyDataText="No records has been added." AutoGenerateEditButton="True"
                ShowHeaderWhenEmpty="True" AutoGenerateDeleteButton="True" Width="500px" Height="100px" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:TemplateField HeaderText="Equipment Name">
                            <EditItemTemplate>
                                <asp:TextBox ID="txt_equipment" runat="server"  Text='<% #Bind("eq_name") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_equipment" runat="server" Text='<% #Eval("eq_name") %>'></asp:Label>
                            </ItemTemplate>                       
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Equipment no.">
                            <EditItemTemplate>
                                <asp:TextBox ID="txt_eq_num" runat="server"  Text='<% #Bind("eq_num") %>' ></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_eq_num" runat="server" Text='<% #Eval("eq_num") %>'></asp:Label>
                            </ItemTemplate> 
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Brand">
                            <EditItemTemplate>
                                <asp:TextBox ID="txt_brand" runat="server"  Text='<% #Bind("eq_brand") %>' ></asp:TextBox>
                            </EditItemTemplate>
                             <ItemTemplate>
                                <asp:Label ID="lbl_brand" runat="server" Text='<% #Eval("eq_brand") %>'></asp:Label>
                            </ItemTemplate> 
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="True" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>
                            </td>
                            <td style="height: 22px; width: 450px"">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style17">&nbsp;</td>
                            <td style="height: 22px; width: 450px"">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style17">&nbsp;</td>
                            <td style="height: 22px; width: 450px"">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style17"></td>
                            <td class="auto-style16"></td>
                        </tr>
                        <tr>
                            <td class="auto-style17">&nbsp;</td>
                            <td style="height: 22px; width: 450px"">&nbsp;</td>
                        </tr>
                    </table>
                </div>
                
            </div>
        </div>
    </div>
</asp:Content>
