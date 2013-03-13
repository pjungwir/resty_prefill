module RestyPrefill

  VERSION = '1.0.1'

  def redirect_and_prefill_for(obj)
    (session[:redirect_and_prefill] ||= {})[obj.class.to_s] ||= {
      attrs: {},
      errors: []
    }
  end

  def clear_redirect_and_prefill_for(obj)
    h = redirect_and_prefill_for(obj)
    h[:attrs] = {}
    h[:errors] = []
  end

  def prefill(obj)
    attrs = redirect_and_prefill_for(obj)[:attrs]
    attrs.each do |k,v|
      obj[k] = v
    end

    errs = redirect_and_prefill_for(obj)[:errors]
    errs.each do |attr, msg|
      obj.errors.add(attr, msg)
    end
  ensure
    clear_redirect_and_prefill_for(obj)
  end

  def ready_prefill(obj, attrs)
    redirect_and_prefill_for(obj)[:attrs] = attrs
    errs = []
    obj.errors.each do |attr, msg|
      errs << [attr, msg]
    end
    redirect_and_prefill_for(obj)[:errors] = errs
  end

end

