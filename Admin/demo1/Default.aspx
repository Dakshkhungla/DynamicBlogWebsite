<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/demo1/Admin.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_demo1_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        /* Centering and enhancing the form layout */
        .form-container {
            max-width: 900px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        /* Label styling for better visibility */
        .form-label {
            font-weight: bold;
            font-size: 15px;
        }

        /* Adjusting input fields for uniformity */
        .form-control {
            border-radius: 6px;
            border: 1px solid #ccc;
            padding: 8px;
        }

        /* Submit button styling */
        .btn-primary {
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 6px;
        }

        /* GridView and table enhancements */
        .table-responsive {
            padding: 20px;
        }

        .display.table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

            .display.table th,
            .display.table td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            .display.table th {
                background: #f8f9fa;
                font-weight: bold;
            }

        /* Adjusting the table's position relative to the sidebar */
        .card {
            margin: 20px;
        }

            /* Making sure GridView and form container have the same width */
            .card .card-header {
                background: #f8f9fa;
                padding: 15px;
                font-weight: bold;
                border-radius: 10px 10px 0 0;
            }

        /* Space between sidebar and table */
        .card-body {
            padding: 20px;
        }

        /* Ensuring some spacing from the right */
        .card {
            margin-right: 20px;
        }
    </style>
    <script type="text/javascript">
        function success(message) {
            alert(message);
        }

        $(document).ready(function () {
            var gridViewId = '<%= GridView1.ClientID %>';

            $('#<%= GridView1.ClientID %>').DataTable({
                "paging": true,
                "searching": true,
                "ordering": true,
                "pageLength": 5
            });
        });
    </script>
    <!--   Core JS Files   -->
    <script src="../assets/js/core/jquery.3.2.1.min.js"></script>
    <script src="../assets/js/core/popper.min.js"></script>
    <script src="../assets/js/core/bootstrap.min.js"></script>
    <!-- jQuery UI -->
    <script src="../assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
    <script src="../assets/js/plugin/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js"></script>

    <!-- jQuery Scrollbar -->
    <script src="../assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
    <!-- Datatables -->
    <script src="../assets/js/plugin/datatables/datatables.min.js"></script>
    <style>
        .form-container {
            max-width: 800px;
            margin: auto;
        }

        .form-label {
            font-weight: 600;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSubmit" />
            <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
        </Triggers>
        <ContentTemplate>


            <div class="card shadow-lg border-0 rounded-12 p-12 form-container">
                <h4 class="text-center text-primary fw-bold mb-12">Add New Blog</h4>

                <asp:Label runat="server" ID="lblMessage" ForeColor="Red"></asp:Label>

                <!-- Blog Name & Author in One Row -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Blog Name</label>
                        <asp:TextBox runat="server" ID="txtBlogName" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBlogName"
                            ErrorMessage="Please enter the blog name!" CssClass="text-danger small" Display="Dynamic" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Author</label>
                        <asp:TextBox runat="server" ID="txtAuthor" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtAuthor"
                            ErrorMessage="Please enter the author's name!" CssClass="text-danger small" Display="Dynamic" />
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtAuthor"
                            ValidationExpression="^[a-zA-Z\s]+$" ErrorMessage="Only letters and spaces allowed!"
                            CssClass="text-danger small" Display="Dynamic" />
                    </div>
                </div>

                <!-- Content in a Separate Row -->
                <div class="row mb-3">
                    <div class="col-md-12">
                        <label class="form-label">Content</label>
                        <asp:TextBox runat="server" ID="txtContent" CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtContent"
                            ErrorMessage="Please enter blog content!" CssClass="text-danger small" Display="Dynamic" />
                    </div>
                </div>

                <!-- Image Upload in a Separate Row -->
                <div class="row mb-3">
                    <div class="col-md-12">
                        <label class="form-label">Upload Image</label>
                        <asp:FileUpload runat="server" ID="fileUploadImage" CssClass="form-control" />
                        <asp:Label ID="Label1" runat="server"></asp:Label>
                       
                       
                    </div>
                </div>
                <asp:HiddenField ID="uid" runat="server" />
                <!-- Submit Button -->
                <div class="text-center">
                    <asp:Button runat="server" ID="btnSubmit" CssClass="btn btn-primary px-4" Text="Submit" OnClick="btnSubmit_Click" />
                </div>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:Blogs %>' DeleteCommand="DELETE FROM [Blogs] WHERE [BlogID] = @BlogID" InsertCommand="INSERT INTO [Blogs] ([BlogName], [Author], [Content], [ImagePath], [CreatedAt]) VALUES (@BlogName, @Author, @Content, @ImagePath, @CreatedAt)" SelectCommand="SELECT * FROM [Blogs]" UpdateCommand="UPDATE [Blogs] SET [BlogName] = @BlogName, [Author] = @Author, [Content] = @Content, [ImagePath] = @ImagePath WHERE [BlogID] = @BlogID">
                    <DeleteParameters>
                        <asp:Parameter Name="BlogID" Type="Int32"></asp:Parameter>
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="BlogName" Type="String"></asp:Parameter>
                        <asp:Parameter Name="Author" Type="String"></asp:Parameter>
                        <asp:Parameter Name="Content" Type="String"></asp:Parameter>
                        <asp:Parameter Name="ImagePath" Type="String"></asp:Parameter>
                        <asp:Parameter Name="CreatedAt" Type="DateTime"></asp:Parameter>
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="BlogName" Type="String"></asp:Parameter>
                        <asp:Parameter Name="Author" Type="String"></asp:Parameter>
                        <asp:Parameter Name="Content" Type="String"></asp:Parameter>
                        <asp:Parameter Name="ImagePath" Type="String"></asp:Parameter>
                        <asp:Parameter Name="BlogID" Type="Int32"></asp:Parameter>
                    </UpdateParameters>
                </asp:SqlDataSource>
            </div>
            </div>
                 
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">Blog Tablet</h4>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <asp:GridView ID="GridView1" OnRowCommand="GridView1_RowCommand" runat="server" CssClass="display table table-striped table-hover" OnPreRender="GridView1_PreRender" OnRowDataBound="GridView1_RowDataBound" AutoGenerateColumns="False" DataKeyNames="BlogID,ImagePath" DataSourceID="SqlDataSource1">
                                    <Columns>

                                        <asp:TemplateField HeaderText="Sr. no">
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex + 1 %>
                                            </ItemTemplate>

                                        </asp:TemplateField>
                                        <asp:BoundField DataField="BlogID" HeaderText="BlogID" ReadOnly="True" InsertVisible="False" SortExpression="BlogID" Visible="false"></asp:BoundField>
                                        <asp:BoundField DataField="BlogName" HeaderText="Name" SortExpression="BlogName"></asp:BoundField>
                                        <asp:BoundField DataField="Author" HeaderText="Author" SortExpression="Author"></asp:BoundField>
                                        <asp:BoundField DataField="Content" HeaderText="Content" SortExpression="Content"></asp:BoundField>
                                        <asp:BoundField DataField="ImagePath" HeaderText="Image" Visible="false" SortExpression="ImagePath"></asp:BoundField>
                                        <asp:TemplateField HeaderText="Blog Image">
                                            <ItemTemplate>
                                                <asp:Image ID="Image2" runat="server" ImageUrl='<%#"../img/" + Eval("ImagePath") %>' Height="70px" Width="100px" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="CreatedAt" HeaderText="Date Published" SortExpression="CreatedAt"></asp:BoundField>
                                        <asp:TemplateField HeaderText="Actions" ItemStyle-Width="200px">
                                            <ItemTemplate>
                                                <asp:Button ID="Edit1" runat="server" CommandName="Edit1" CausesValidation="false" ToolTip="Edit" CssClass="btn btn-primary" OnClick="Edit1" Text="Edit" CommandArgument='<%#Eval("BlogId") %>' />
                                                <asp:Button ID="Del" runat="server" CommandName="del" CausesValidation="false" ToolTip="Delete" Text="Delete" OnClientClick="return confirm('Are you Sure ,you want to delete this.');" CssClass="btn btn-danger" CommandArgument='<%#Eval("BlogId") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
