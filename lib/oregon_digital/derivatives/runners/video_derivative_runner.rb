module OregonDigital::Derivatives::Runners
  # Simple container for scale: the one common (and complex) option all video
  # derivatives need to share
  class VideoDerivativeRunner < DerivativeRunner
    # Tells ffmpeg how to fill the desired area: if aspect ratio is > 1.0,
    # resize to the max width, otherwise resize to the max height.  In either
    # case, preserve the ratio.
    def scale(w, h)
      "'if(gt(a,1),%d,-1)':'if(gt(a,1),-1,%d)'" % [w, h]
    end
  end
end
