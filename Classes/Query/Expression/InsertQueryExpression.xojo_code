#tag Class
Protected Class InsertQueryExpression
Implements QueryExpression
	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function Compile(pLastQueryExpression As QueryExpression = Nil) As String
		  #Pragma Unused pLastQueryExpression
		  
		  Dim pColumns As String
		  
		  // No columns makes a simple insertion
		  If mColumns.Ubound > -1 Then
		    pColumns = " ( " + QueryCompiler.Columns(mColumns) + " )"
		  End If
		  
		  Return "INSERT INTO " + QueryCompiler.TableName(mTableName) + pColumns  // MYSQL fonctionne avec IGNORE INTO et SQLITE OR IGNORE INTO, trouver solution pour faire un choix
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
		Function Compile(pLastQueryExpression As QueryExpression = Nil) As String
		  #Pragma Unused pLastQueryExpression
		  
		  Dim pColumns As String
		  
		  // No columns makes a simple insertion
		  If mColumns.Ubound > -1 Then
		    pColumns = " ( " + QueryCompiler.Columns(mColumns) + " )"
		  End If
		  
		  Return "INSERT OR IGNORE INTO " + QueryCompiler.TableName(mTableName) + pColumns  // MYSQL fonctionne avec IGNORE INTO et SQLITE OR IGNORE INTO, trouver solution pour faire un choix
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(pTableName As String, pColumns() As Variant)
		  mTableName = pTableName
		  mColumns = pColumns
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Nice() As Integer
		  Return 1
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mColumns() As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTableName As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
