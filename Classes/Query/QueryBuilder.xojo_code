#tag Class
Protected Class QueryBuilder
Implements QueryExpression
	#tag Method, Flags = &h0
		Function AndHaving(pLeft As Variant, pOperator As String, pRight As Variant) As QueryBuilder
		  mQuery.Append(new AndHavingQueryExpression(pLeft, pOperator, pRight))
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AndWhere(pLeft As Variant, pOperator As String, pRight As Variant) As QueryBuilder
		  mQuery.Append(new AndWhereQueryExpression(pLeft, pOperator, pRight))
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Append(pQueryExpression As QueryExpression) As QueryBuilder
		  mQuery.Append(pQueryExpression)
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Compile() As String
		  Dim pStatements() As String
		  Dim pNice As Integer
		  
		  // Sort statements
		  While pStatements.Ubound < mQuery.Ubound
		    
		    For i As Integer = 0 To mQuery.Ubound
		      
		      Dim pQueryExpression As QueryExpression = mQuery(i)
		      
		      If pQueryExpression.Nice() = pNice Then
		        pStatements.Append(pQueryExpression.Compile())
		      End If
		      
		    Next
		    
		    pNice = pNice + 1
		    
		  WEnd
		  
		  Return Join(pStatements, " ")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Execute(pDatabase As Database)
		  RaiseEvent Executing()
		  
		  Dim pStatement As String = Compile()
		  
		  pDatabase.SQLExecute(pStatement)
		  
		  If pDatabase.Error Then
		    Raise New ORMException(pDatabase.ErrorMessage + " " + pStatement)
		  End If
		  
		  pDatabase.Commit()
		  
		  Call Reset()
		  
		  RaiseEvent Executed()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Execute(pDatabase As Database) As RecordSet
		  RaiseEvent Executing()
		  
		  Dim pStatement As String = Compile()
		  
		  Dim pRecordSet As RecordSet = pDatabase.SQLSelect(pStatement)
		  
		  If pDatabase.Error Then
		    Raise New ORMException(pDatabase.ErrorMessage + " " + pStatement)
		  End If
		  
		  pDatabase.Commit()
		  
		  Call Reset()
		  
		  RaiseEvent Executed()
		  
		  Return pRecordSet
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function From(pTableName As String) As QueryBuilder
		  Return From(pTableName, pTableName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function From(pTableName As String, pTableAlias As String) As QueryBuilder
		  mQuery.Append(new FromQueryExpression(pTableName, pTableAlias))
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GroupBy(pColumns() As Variant) As QueryBuilder
		  mQuery.Append(new GroupByQueryExpression(pColumns))
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GroupBy(pColumn As Variant) As QueryBuilder
		  Return GroupBy(Array(pColumn))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Having(pCriterias As Dictionary) As QueryBuilder
		  // Applies a dictionary of criterias
		  
		  For Each pKey As Variant In pCriterias.Keys()
		    Call Having(pKey, "=", pCriterias.Value(pKey))
		  Next
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Having(pLeft As Variant, pOperator As String, pRight As Variant) As QueryBuilder
		  mQuery.Append(new HavingQueryExpression(pLeft, pOperator, pRight))
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Join(pTableName As String) As QueryBuilder
		  Return Join(pTableName, pTableName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Join(pTableName As String, pAlias As String) As QueryBuilder
		  mQuery.Append(new JoinQueryExpression(pTableName, pAlias))
		  
		  return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Limit(pLimit As Integer) As QueryBuilder
		  mQuery.Append(new LimitQueryExpression(pLimit))
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Nice() As Integer
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Offset(pOffset As Integer) As QueryBuilder
		  mQuery.Append(new OffsetQueryExpression(pOffset))
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function On(pLeft As Variant, pOperator As String, pRight As Variant) As QueryBuilder
		  mQuery.Append(new OnQueryExpression(pLeft, pOperator, pRight))
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OrderBy(pColumns() As Variant, pDirections() As String) As QueryBuilder
		  mQuery.Append(new OrderByQueryExpression(pColumns, pDirections))
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OrderBy(pColumn As Variant, pDirection As String = "ASC") As QueryBuilder
		  mQuery.Append(new OrderByQueryExpression(Array(pColumn), Array(pDirection)))
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OrHaving(pLeft As Variant, pOperator As String, pRight As Variant) As QueryBuilder
		  mQuery.Append(new OrHavingQueryExpression(pLeft, pOperator, pRight))
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OrWhere(pLeft As Variant, pOperator As String, pRight As Variant) As QueryBuilder
		  mQuery.Append(new OrWhereQueryExpression(pLeft, pOperator, pRight))
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Reset() As QueryBuilder
		  // Réinitalise le Query Builder
		  Redim mQuery(-1)
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Set(pValues As Dictionary) As QueryBuilder
		  mQuery.Append(new SetQueryExpression(pValues))
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Set(ParamArray pValues As Pair) As QueryBuilder
		  Dim pDictionary As Dictionary
		  
		  For Each pValue As Pair In pValues
		    pDictionary.Value(pValue.Left) = pValue.Right
		  Next
		  
		  Return Set(pDictionary)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Using(pLeft As Variant, pOperator As String, pRight As Variant) As QueryBuilder
		  mQuery.Append(new UsingQueryExpression(pLeft, pOperator, pRight))
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Values(pValues() As Variant) As QueryBuilder
		  mQuery.Append(new ValuesQueryExpression(pValues))
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Values(ParamArray pValues As Variant) As QueryBuilder
		  Return Values(pValues)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Where(pCriterias As Dictionary) As QueryBuilder
		  // Applies a dictionary of criterias
		  
		  For Each pKey As Variant In pCriterias.Keys()
		    Call Having(pKey, "=", pCriterias.Value(pKey))
		  Next
		  
		  Return Me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Where(pLeft As Variant, pOperator As String, pRight As Variant) As QueryBuilder
		  mQuery.Append(new WhereQueryExpression(pLeft, pOperator, pRight))
		  
		  Return Me
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Executed()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Executing()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mQuery() As QueryExpression
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
