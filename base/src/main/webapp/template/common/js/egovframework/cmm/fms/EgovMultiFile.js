/**
 * Convert a single file-input element into a 'multiple' input list
 * Usage:
 *
 *   1. Create a file input element (no name)
 *      eg. <input type="file" id="first_file_element">
 *
 *   2. Create a DIV for the output to be written to
 *      eg. <div id="files_list"></div>
 *
 *   3. Instantiate a MultiSelector object, passing in the DIV and an (optional) maximum number of files
 *      eg. var multi_selector = new MultiSelector( document.getElementById( 'files_list' ), 3 );
 *
 *   4. Add the first element
 *      eg. multi_selector.addElement( document.getElementById( 'first_file_element' ) );
 */

var denyFileExtentionList = new Array(".sh", ".exe");
function MultiSelector( list_target, max ){

	// Where to write the list
	this.list_target = list_target;
	// How many elements?
	this.count = 0;
	// How many elements?
	this.id = 0;
	// Is there a maximum?
	if( max ){
		this.max = max;
	} else {
		this.max = -1;
	};
	
	/**
	 * Add a new file input element
	 */
	this.addElement = function( element ){

		// Make sure it's a file input element
		if( element.tagName == 'INPUT' && element.type == 'file' ){

			// Element name -- what number am I?
			element.name = 'file_' + this.id++;

			// Add reference to this object
			element.multi_selector = this;

			// What to do when a file is selected
			element.onchange = function(){				
				// New file input
				var new_element = document.createElement( 'input' );
				new_element.type = 'file';
				//new_element.className = 'boardfilein';
				//new_element.size = 75;
				new_element.style.width = "100%";
				new_element.style.height = "22px";
				
				// Add new element
				this.parentNode.insertBefore( new_element, this );

				// Apply 'update' to element
				this.multi_selector.addElement( new_element );

				// Update list
				this.multi_selector.addListRow( this );
				
				// Hide this: we can't use display:none because Safari doesn't like it
				this.style.position = 'absolute';
				this.style.left = '-1000px';
				this.style.top = '-1000px';
				this.style.display = 'none';
				this.style.visibility = 'hidden';
				this.style.width = '0';
				this.style.height = '0';
				this.style.overflow = 'hidden';

				new_element.onkeypress = function(){
					return false;
				};

			};
			// If we've reached maximum number, disable input element
			if( this.max != -1 && this.count >= this.max ){
				element.disabled = true;
			};

			// File element counter
			this.count++;
			// Most recent element
			this.current_element = element;
			
		} else {
			// This can only be applied to file input elements!
			alert( 'Error: not a file input element' );
		};

	};

	/**
	 * Add a new row to the list of files
	 */
	this.addListRow = function( element ){
		
		// Row div
		var new_row = document.createElement( 'div' );

		// Delete button
		//var new_row_button = document.createElement( 'input' );
		var new_row_button = document.createElement( 'img' );
		//new_row_button.type = 'button';
		new_row_button.src="/template/common/images/page/board/icon_del.gif";
		new_row_button.alt="삭제";	// 추가 by moon 2011.09.07
		new_row_button.style.verticalAlign = "middle"; // 추가 by moon 2011.09.07
		

		// References
		new_row.element = element;

		// Delete function
		new_row_button.onclick= function(){

			// Remove element from form
			this.parentNode.element.parentNode.removeChild( this.parentNode.element );

			// Remove this row from the list
			this.parentNode.parentNode.removeChild( this.parentNode );

			// Decrement counter
			this.parentNode.element.multi_selector.count--;

			// Re-enable input element (if it's disabled)
			this.parentNode.element.multi_selector.current_element.disabled = false;

			//    which nixes your already queued uploads
			return false;
		};

		// Set row value
		new_row.innerHTML = "<img src='/template/common/images/page/board/icon_file.gif' alt='첨부파일' style='vertical-align:middle;'/><span style='padding:0 10px;'>"+element.value+"</span>"; // 수정 by moon 2011.09.07
		
		// Add button
		new_row.appendChild( new_row_button );

		// Add it to the list
		this.list_target.appendChild( new_row );
		
		var extection = element.value.substring(element.value.lastIndexOf('.'), element.value.length).toLowerCase();
		for(var i=0; i < denyFileExtentionList.length; i++) {
			if(extection == denyFileExtentionList[i]) {
				new_row_button.click();
				alert('허용되지 않은 파일입니다.');
			}
		}
	};

};



/**
 * MultiSelectorEx : 이미지 Path 받음
 * addElement(element, imgPath)
 * */
function MultiSelectorEx( list_target, max ){

	// Where to write the list
	this.list_target = list_target;
	// How many elements?
	this.count = 0;
	// How many elements?
	this.id = 0;
	// Is there a maximum?
	if( max ){
		this.max = max;
	} else {
		this.max = -1;
	};
	
	/**
	 * Add a new file input element
	 */
	this.addElement = function( element, imgPath ){
		// Make sure it's a file input element
		if( element.tagName == 'INPUT' && element.type == 'file' ){
			// Element name -- what number am I?
			element.name = 'file_' + this.id++;
			// Add reference to this object
			element.multi_selector = this;
			// What to do when a file is selected
			element.onchange = function(){				
				// New file input
				var new_element = document.createElement( 'input' );
				new_element.type = 'file';
				//new_element.className = 'boardfilein';
				//new_element.size = 75;
				new_element.style.width = "100%";
				new_element.style.height = "22px";
				
				// Add new element
				this.parentNode.insertBefore( new_element, this );

				// Apply 'update' to element
				this.multi_selector.addElement( new_element, imgPath );

				// Update list
				this.multi_selector.addListRow( this, imgPath );
				
				// Hide this: we can't use display:none because Safari doesn't like it
				this.style.position = 'absolute';
				this.style.left = '-1000px';
				this.style.top = '-1000px';
				this.style.display = 'none';
				this.style.visibility = 'hidden';
				this.style.width = '0';
				this.style.height = '0';
				this.style.overflow = 'hidden';

				new_element.onkeypress = function(){
					return false;
				};
			};
			// If we've reached maximum number, disable input element
			if( this.max != -1 && this.count >= this.max ){
				element.disabled = true;
			};
			// File element counter
			this.count++;
			// Most recent element
			this.current_element = element;			
		} else {
			// This can only be applied to file input elements!
			alert( 'Error: not a file input element' );
		};
	};

	/**
	 * Add a new row to the list of files
	 */
	this.addListRow = function( element, imgPath ){
		
		// Row div
		var new_row = document.createElement( 'div' );

		// Delete button
		//var new_row_button = document.createElement( 'input' );
		var new_row_button = document.createElement( 'img' );
		//new_row_button.type = 'button';
		new_row_button.src= imgPath + "/btn_sdelete.gif"; // 수정 by moon 2012.10.18
		new_row_button.alt="삭제";	// 추가 by moon 2011.09.07
		new_row_button.style.verticalAlign = "middle"; // 추가 by moon 2011.09.07
		

		// References
		new_row.element = element;

		// Delete function
		new_row_button.onclick= function(){
			this.parentNode.element.parentNode.removeChild( this.parentNode.element );
			this.parentNode.parentNode.removeChild( this.parentNode );
			this.parentNode.element.multi_selector.count--;
			this.parentNode.element.multi_selector.current_element.disabled = false;
			return false;
		};

		new_row.innerHTML = "<img src='"+imgPath+"/ico_file.gif' alt='첨부파일' style='vertical-align:middle;'/><span style='padding:0 5px;'>"+element.value+"</span>"; // 수정 by moon 2012.10.18
		
		// Add button
		new_row.appendChild( new_row_button );

		// Add it to the list
		this.list_target.appendChild( new_row );
		
		var extection = element.value.substring(element.value.lastIndexOf('.'), element.value.length).toLowerCase();
		for(var i=0; i < denyFileExtentionList.length; i++) {
			if(extection == denyFileExtentionList[i]) {
				new_row_button.click();
				alert('허용되지 않은 파일입니다.');
			}
		}
	};

};