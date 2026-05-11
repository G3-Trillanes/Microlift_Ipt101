<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <body style="margin:0;  font-family: Arial, sans-serif;background-color: #82cbffc6">
                <div style="background-color:#1a3b64; padding:10px; margin:0;">
                    <h2 style="padding:10px; color:white; font-size:35px;">
                        MICROLIFT
                    </h2>
                    <div style="border-bottom:2px solid white; width:100%;"></div>
                </div>

                <div style="display:flex; align-items:center; margin-top:15px; justify-content:center; gap:20px;">

                    <div style="display:flex; flex-direction:column; align-items:center;">
                        <div style="padding:10px; margin:0; display:flex; align-items:center; justify-content:flex-start; width:100%;">
                            <img src="Admin.png" alt="Logo" style="height:40px; margin-right:10px;
filter: brightness(0) saturate(100%) invert(17%) sepia(14%) saturate(1758%) hue-rotate(178deg) brightness(94%) contrast(92%);" />
                            <h2 style="margin:0; color:#1a3b64;">Admins</h2>
                        </div>
                        <div style="border-bottom:2px solid #1a3b64; width:100%; margin:5px 0; padding 10px;"></div>
                        <table border="0" style="width: 800px; border-collapse: collapse; overflow: hidden; font-size:16px; background-color:#7295c0; color:#e7eaed;">
                            <tr style="background-color:#1a3b64; font-weight:bold;">
                                <th style="padding: 10px;">ID</th>
                                <th style="padding: 10px;">Name</th>
                                <th style="padding: 10px;">Email</th>
                                <th style="padding: 10px;">Location</th>
                                <th style="padding: 10px;">Status</th>
                            </tr>
                            <xsl:for-each select="MicroLift/Admin">
                                <tr>
                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="AdminID"/>
                                    </td>
                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="AdminName"/>
                                    </td>
                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="AdminEmail"/>
                                    </td>
                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="AdminLocation"/>
                                    </td>
                                    <td>
                                        <xsl:attribute name="style">
        padding:10px; text-align:center; color:white; 
                                            <xsl:choose>
                                                <xsl:when test="Status='Active'">
                background-color:#3a793a;
                                                </xsl:when>
                                                <xsl:otherwise>
                background-color:#bd3200;
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:attribute>

                                        <xsl:value-of select="Status"/>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </div>

                    <div style="display:flex; flex-direction:column; align-items:center;">
                        <div style="padding:10px; margin:0; display:flex; align-items:center; justify-content:flex-start; width:100%;">
                            <img src="Employer.png" alt="Logo" style="height:40px; margin-right:10px;
filter: brightness(0) saturate(100%) invert(17%) sepia(14%) saturate(1758%) hue-rotate(178deg) brightness(94%) contrast(92%);" />
                            <h2 style="margin:0; color:#1a3b64;">Employer</h2>
                        </div>
                        <div style="border-bottom:2px solid #1a3b64; width:100%; margin:5px 0; padding 10px;"></div>
                        <table border="0" style="width: 800px; border-collapse: collapse; overflow: hidden; font-size:16px; background-color:#7295c0; color:#e7eaed;">
                            <tr style="background-color:#1a3b64; font-weight:bold;">
                                <th style="padding: 10px;">ID</th>
                                <th style="padding: 10px;">Name</th>
                                <th style="padding: 10px;">Contact</th>
                                <th style="padding: 10px;">Industry</th>
                                <th style="padding: 10px;">Location</th>
                            </tr>
                            <xsl:for-each select="MicroLift/Employer">
                                <tr>
                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="EmployerID"/>
                                    </td>
                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="EmployerName"/>
                                    </td>
                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="EmployerContact"/>
                                    </td>
                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="Industry"/>
                                    </td>
                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="EmployerLocation"/>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </div>

                </div>


                <div style="display:flex; align-items:center; margin-top:15px; justify-content:center; gap:20px;">

                    <div style="display:flex; flex-direction:column; align-items:center;">
                        <div style="padding:10px; margin:0; display:flex; align-items:center; justify-content:flex-start; width:100%;">
                            <img src="Job.png" alt="Logo" style="height:40px; margin-right:10px;
filter: brightness(0) saturate(100%) invert(17%) sepia(14%) saturate(1758%) hue-rotate(178deg) brightness(94%) contrast(92%);" />
                            <h2 style="margin:0; color:#1a3b64;">Job</h2>
                        </div>
                        <div style="border-bottom:2px solid #1a3b64; width:100%; margin:5px 0; padding 10px;"></div>
                        <table border="0" style="width: 800px; border-collapse: collapse; overflow: hidden; font-size:16px; background-color:#7295c0; color:#e7eaed;">
                            <tr style="background-color:#1a3b64; font-weight:bold;">
                                <th style="padding:10px;">Job ID</th>
                                <th style="padding:10px;">Job Name</th>
                                <th style="padding:10px;">Category</th>
                                <th style="padding:10px;">Type</th>
                                <th style="padding:10px;">Location</th>
                                <th style="padding:10px;">Status</th>
                            </tr>
                            <xsl:for-each select="MicroLift/Job">
                                <tr>
                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="@jobID"/>
                                    </td>
                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="JobName"/>
                                    </td>
                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="@category"/>
                                    </td>
                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="JobType"/>
                                    </td>
                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="JobLocation"/>
                                    </td>
                                    <td>
                                        <xsl:attribute name="style">
        padding:10px; text-align:center;
                                            <xsl:choose>
                                                <xsl:when test="Status='Open'">
        background-color:#3a793a;
                                                </xsl:when>

                                                <xsl:when test="Status='Reopened'">
        background-color:#d4a017;
                                                </xsl:when>

                                                <xsl:otherwise>
        background-color:#bd3200;
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:attribute>

                                        <xsl:value-of select="Status"/>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </div>

                    <div style="display:flex; flex-direction:column; align-items:center;">
                        <div style="padding:10px; margin:0; display:flex; align-items:center; justify-content:flex-start; width:100%;">
                            <img src="Job_humt.png" alt="Logo" style="height:40px; margin-right:10px;
filter: brightness(0) saturate(100%) invert(17%) sepia(14%) saturate(1758%) hue-rotate(178deg) brightness(94%) contrast(92%);" />
                            <h2 style="margin:0; color:#1a3b64;">Job Hunters</h2>
                        </div>
                        <div style="border-bottom:2px solid #1a3b64; width:100%; margin:5px 0; padding 10px;"></div>
                        <table border="0" style="width: 800px; border-collapse: collapse; overflow: hidden; font-size:16px; background-color:#7295c0; color:#e7eaed;">
                            <tr style="background-color:#1a3b64; font-weight:bold;">
                                <th style="padding:10px;">ID</th>
                                <th style="padding:10px;">Name</th>
                                <th style="padding:10px;">Email</th>
                                <th style="padding:10px;">Location</th>
                                <th style="padding:10px;">Availability</th>
                            </tr>
                            <xsl:for-each select="MicroLift/JobHunter">
                                <tr>
                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="JobHunterID"/>
                                    </td>

                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="JobHunterName"/>
                                    </td>

                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="JobHunterEmail"/>
                                    </td>

                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="concat(JobHunterLocation)"/>
                                    </td>

                                    <!-- Availability with color -->
                                    <td>
                                        <xsl:attribute name="style">
        padding:10px; text-align:center;
                                            <xsl:choose>
                                                <xsl:when test="Availability='Available'">
                background-color:#3a793a;
                                                </xsl:when>
                                                
                                                <xsl:otherwise>
                background-color:#bd3200;
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:attribute>

                                        <xsl:value-of select="Availability"/>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </div>

                </div>

                <div style="display:flex; align-items:center; margin-top:15px; justify-content:center; gap:20px;">

                    <div style="display:flex; flex-direction:column; align-items:center;">
                        <div style="padding:10px; margin:0; display:flex; align-items:center; justify-content:flex-start; width:100%;">
                            <img src="pay.png" alt="Logo" style="height:40px; margin-right:10px;
filter: brightness(0) saturate(100%) invert(17%) sepia(14%) saturate(1758%) hue-rotate(178deg) brightness(94%) contrast(92%);" />
                            <h2 style="margin:0; color:#1a3b64;">Payment</h2>
                        </div>
                        <div style="border-bottom:2px solid #1a3b64; width:100%; margin:5px 0; padding 10px;"></div>
                        <table border="0" style="width: 800px; border-collapse: collapse; overflow: hidden; font-size:16px; background-color:#7295c0; color:#e7eaed;">
                            <tr style="background-color:#1a3b64;">
                                <th style="padding:10px;">ID</th>
                                <th style="padding:10px;">Job ID</th>
                                <th style="padding:10px;">Job Hunter</th>
                                <th style="padding:10px;">Amount</th>
                                <th style="padding:10px;">Date</th>
                                <th style="padding:10px;">Reference</th>
                            </tr>
                            <xsl:for-each select="MicroLift/Payment">
                                <tr>
                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="PaymentID"/>
                                    </td>

                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="JobID"/>
                                    </td>
                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="JobHunterID"/>
                                    </td>

                                    <td style="padding:10px; text-align:center;">
                                     ₱                                        <xsl:value-of select="PaymentAmount"/>
                                    </td>

                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="PaymentDate"/>
                                    </td>

                                    <td style="padding:10px; text-align:center;">
                                        <xsl:value-of select="PaymentReference"/>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>