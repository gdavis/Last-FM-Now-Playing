package com.gdi.core.view {

	/**
	 * @author grantdavis
	 */
	public interface IViewControllerDelegate {
		function viewDidAnimateIn( $view :BaseView ):void;
		function viewDidAnimateOut( $view :BaseView ):void;
	}
}
