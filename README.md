resty\_prefill
==============

The resty\_prefill gem fixes a problem with Rails' REST behavior when handling form-submit errors. I've written more about this problem [here](http://www.illuminatedcomputing.com/posts/2011/07/restless-doubts/), but basically it's this:

A typical Rails controller has these methods:

    class WidgetsController < ApplicationController

      def new
        @widget = Widget.new
      end

      def create
        @widget = Widget.new(params[:widget])
        if @widget.save
          flash[:success] = 'Widget created.'
          redirect_to widgets_path
        else
          render 'new'
        end
      end

      def edit
        @widget = Widget.find(params[:id])
      end

      def update
        @widget = Widget.find(params[:id])
        if @widget.update_attributes(params[:widget])
          flash[:success] = 'Widget updated.'
          redirect_to widgets_path
        else
          render 'edit'
        end
      end

      # ...

    end

The problem is how this approach handles errors. To create a Widget, the user starts at `/widgets/new`, but after getting errors he winds up at just `/widgets`. That URL is non-GETtable, non-bookmarkable, and non-sharable. If you do Ctrl-L then Enter, you'll get a routing error. If you click "Like" or "Share", people following your URL get a routing error. It messes up Google Analytics, too. Ideally form errors should send the user back to `/widgets/new`. Similarly with `/widgets/2/edit` vs. `/widgets/2`.

So resty\_prefill makes it easy to preserve RESTful URLs even with form errors. Just `include RestyPrefill` in your ApplicationController, then write your code like this:

    class WidgetsController < ApplicationController

      def new
        @widget = Widget.new
        prefill @widget
      end

      def create
        @widget = Widget.new(params[:widget])
        if @widget.save
          flash[:success] = 'Widget created.'
          redirect_to widgets_path
        else
          ready_prefill @widget, params[:widget]
          redirect_to new_widget_path
        end
      end

      def edit
        @widget = Widget.find(params[:id])
        prefill @widget
      end

      def update
        @widget = Widget.find(params[:id])
        if @widget.update_attributes(params[:widget])
          flash[:success] = 'Widget updated.'
          redirect_to widgets_path
        else
          ready_prefill @widget, params[:widget]
          redirect_to edit_widget_path(@widget)
        end
      end

      # ...

    end

The `prefill` method populates `@widget.errors` so your form displays the right messages and highlights the right fields. The `ready_prefill` method stores information in the session to make this possible.


Contributing to resty\_prefill
------------------------------

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone hasn't already requested and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make be sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, that is fine, but please isolate that change to its own commit so I can cherry-pick around it.

Commands for building/releasing/installing:

* `rake build`
* `rake install`
* `rake release`

Copyright
---------

Copyright (c) 2013 Illuminated Computing Inc.
See LICENSE.txt for further details.

